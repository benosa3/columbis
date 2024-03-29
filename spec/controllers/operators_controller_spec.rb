# -*- encoding : utf-8 -*-
require 'spec_helper'

describe OperatorsController do
  def create_operator
    @operator = FactoryGirl.create(:operator)
    @user = FactoryGirl.create(:admin)
    test_sign_in(@user)
  end

  before (:each) do
    create_operator
  end

  describe 'GET edit' do
    def do_get
      get :edit, :id => @operator.id
    end

    before (:each) do
      do_get
    end

    it 'should render operators/edit' do
      puts response.body.inspect
      response.should render_template('edit')
    end

    it 'should be successful' do
      response.should be_success
    end
  end

  describe 'PUT update' do
    def do_put
      put :update, :id => @operator.id, :operator => {:name => 'changed_operator'}
    end

    before(:each) do
      do_put
    end

    it 'should change operator name' do
      assigns[:operator].name.should == 'changed_operator'
    end

    it 'should redirect to operators/show.html' do
      response.should redirect_to operators_path
    end

    it 'should update claim updated_at if update operator name' do
      Delayed::Worker.delay_jobs = false
      @claim = FactoryGirl.create(:claim, company: @user.company, office: @user.office, user: @user, operator_id: @operator.id)
      put :update, id: @operator.id, operator: attributes_for(:operator, name: 'ivanov')
      Claim.find(@claim.id).updated_at.should > @claim.updated_at
    end
  end

  describe 'DELETE destroy' do
    def do_delete
      delete :destroy, :id => @operator.id
    end

    it 'should be successful' do
      response.should be_success
    end

    it 'should redirect to operators/index.html' do
      do_delete
      response.should redirect_to(operators_path)
    end

    it 'should change operators count down by 1' do
      lambda { do_delete }.should change{ Operator.count }.by(-1)
    end
  end

  describe 'GET show' do
    def do_get
      get :show, :id => @operator.id
    end

    before (:each) do
      do_get
    end

    it 'should be successful' do
      response.should be_success
    end

    it 'should find right operator' do
      assigns[:operator].id.should == @operator.id
    end

    it 'should render operators/edit.html' do
      response.should render_template('edit')
    end
  end

  describe 'GET index' do
    def do_get
      get :index
    end

    it 'should be successful' do
      do_get
      response.should be_success
    end

    it 'should find all operators' do
      do_get
      assigns[:operators].size.should > 0
    end

    it 'should render operators/index.html' do
      do_get
      response.should render_template('index')
    end
  end

  describe 'GET new' do
    def do_get
      get :new
    end

    before (:each) do
      do_get
    end

    it 'should render operators/new' do
      response.should render_template('new')
    end

    it 'should be successful' do
      response.should be_success
    end
  end

  describe 'POST create' do
    def do_operator
      post :create, :operator => {:name => 'another operator'}
    end

    it 'should redirect to operators/show.html' do
      do_operator
      response.should redirect_to operators_path
    end

    it 'should change operators count up by 1' do
      lambda { do_operator }.should change{ Operator.count }.by(1)
    end
  end
end
