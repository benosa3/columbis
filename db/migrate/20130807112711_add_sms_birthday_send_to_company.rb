class AddSmsBirthdaySendToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :sms_birthday_send, :boolean, default: true
  end
end
