# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'test' }
    body { 'Hello, world！' }
  end

  trait :user do
    transient do
      username { 'sampleuser' }
      email { 'member@example.com' }
      password { '123456' }
      password_confirmation { '123456' }
    end
  end
end
