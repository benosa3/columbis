# -*- encoding : utf-8 -*-
class AddCalculationToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :calculation, :string
  end
end
