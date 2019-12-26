# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'test' }
    body { 'Hello, world！' }
  end
end
