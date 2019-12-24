FactoryBot.define do
  factory :user do
    username { 'testuser' }
    email { 'test@example.com' }
    password { 'test12345' }
  end
end
