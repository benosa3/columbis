# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :item do
    association :catalog
    association :company
  end
end
