require 'rails_helper'

describe '投稿のシステムテスト', type: :system do
  let(:user) { FactoryBot.create :user }

  describe '投稿の新規作成' do
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログインする'
    end
  end
end
