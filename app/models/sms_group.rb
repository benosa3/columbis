class SmsGroup < ActiveRecord::Base
  has_many :sms_touristgroups
  has_many :tourists, through: :sms_touristgroups
  
  attr_accessible :contact_count, :name, :company_id
  
  validates :name,  :presence => true
  
  scope :current_company, lambda { |id| where(company_id: id) }
end
