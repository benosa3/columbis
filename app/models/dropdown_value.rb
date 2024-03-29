# -*- encoding : utf-8 -*-
class DropdownValue < ActiveRecord::Base
  attr_accessible :list, :value
  attr_protected :company_id
  belongs_to :company

  validates_presence_of :list, :value
  validates_presence_of :company_id, :if => Proc.new { |dd| dd.common == false }
  validates_uniqueness_of :value, :scope => [:company_id, :list]

  scope :common, where(:common => true)

  define_index do
    indexes :list, :value, :sortable => true
    has :common, :type => :boolean
    has :company_id
    set_property :delta => true
  end

  sphinx_scope(:by_list) { { :order => [:list, :id] } }
  default_sphinx_scope :by_list

  def self.available_lists
    I18n.t('dropdown_values.available_lists')
  end

  def self.check_and_save(list, value, company_id, common = false)
    # Clean value from trailing spaces
    value.strip! if value.is_a? String
    # Don't store blank values
    return if value.blank?
    # Check current value
    unless where(:list => list, :value => value, :company_id => company_id).first
      # we don't store common values
      return if where(:list => list, :value => value, :common => true).first

      dd = new( :list => list, :value => value )
      dd.company_id = company_id
      dd.save
    end
  end

  def self.dd_for(list, company_id, include_common = true)
    DropdownValue.where( 'list = ? AND (company_id = ? OR common = ?)', list, company_id, include_common ).order('common DESC, value ASC')
  end

  def self.values_for(list, company_id, include_common = true)
    self.dd_for(list, company_id, include_common).map &:value
  end
end
