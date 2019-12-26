FactoryBot.define do
  factory :user do
    username { 'testuser' }
    email { 'test@example.com' }
    password { 'test12345' }
    password_confirmation { 'test12345' }
    created_at { Date.today }
  end
end
