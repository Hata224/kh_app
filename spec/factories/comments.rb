# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'MyString' }
    association :post
    association :user
  end
end
