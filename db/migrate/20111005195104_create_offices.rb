# -*- encoding : utf-8 -*-
class CreateOffices < ActiveRecord::Migration
  def self.up
    create_table :offices do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :offices
  end
end
