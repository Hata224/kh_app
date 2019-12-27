require 'rails_helper'

RSpec.describe 'ログインに関するテスト', type: :system do
  before do
    visit new_user_session_path
  end

  describe 'ログインが有効である場合' do
    before do
      user = FactoryBot.create(:user)
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    it 'ユーザー詳細画面にリダイレクトされること' do
      expect(current_path).to eq(user_session_path)
    end
  end
end
