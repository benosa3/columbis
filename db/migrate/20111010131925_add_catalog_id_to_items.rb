# -*- encoding : utf-8 -*-
class AddCatalogIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :catalog_id, :integer
  end
end
