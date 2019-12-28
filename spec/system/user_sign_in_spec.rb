require 'rails_helper'

RSpec.describe 'ログインに関するテスト', type: :system do
  before do
    visit new_user_session_path
  end

  context 'ログインが有効である場合' do
    before do
      user = FactoryBot.create(:user)
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログインする'
    end

    it 'ユーザー詳細画面にリダイレクトされること' do
      expect(current_path).to eq(user_session_path)
    end
  end

  context 'ログインが無効である場合' do
    before do
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      click_button 'ログインする'
    end

    it 'ルートにリダイレクトされないこと' do
      expect(current_path).to_not eq(root_path)
    end

    it 'エラーメッセージが表示されること' do
      expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
    end
  end
end
