class Claim < ActiveRecord::Base
  attr_accessible :user_id, :tourist_id, :check_date, :description, :office_id, :operator_id, :operator_confirmation, :visa,
                  :airport_to, :airport_back, :flight_to, :flight_back, :depart_to, :depart_back, :time_to, :time_back  


  belongs_to :user
  belongs_to :tourist
  has_many :tourists

  validates_presence_of :user_id
  validates :currency, :inclusion => CurrencyCourse::CURRENCIES
  validates_presence_of :course, :currency
end

