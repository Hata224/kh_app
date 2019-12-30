require 'rails_helper'

RSpec.describe 'ユーザー登録についてのテスト', type: :system do
  before do
    visit new_user_registration_path
  end

  describe '有効なユーザー登録である場合' do
    before do
      expect do
        fill_in 'ユーザー名', with: 'testuser'
        fill_in 'メールアドレス', with: 'testtest@example.com'
        fill_in 'パスワード', with: 'test12345'
        fill_in '確認用パスワード', with: 'test12345'
        click_button '新規登録'
      end.to change(User, :count).by(1)
    end

    it 'ルートにリダイレクトされること' do
      expect(current_path).to eq(root_path)
    end

    it '本人確認のメッセージが表示されること' do
      expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
    end

    it 'ログインが表示されていること' do
      expect(page).to have_content 'ログイン'
    end

    it 'かんたんログインが表示されていること' do
      expect(page).to have_content 'かんたんログイン'
    end

    it '新規登録が表示されること' do
      expect(page).to have_content '新規登録'
    end
  end

  describe '無効なユーザ登録である場合' do
    before do
      fill_in 'ユーザー名', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: 'aaaaaa'
      fill_in '確認用パスワード', with: 'aaaaaa'
      click_button '新規登録'
    end

    it 'メールが送られないこと' do
      expect(ActionMailer::Base.deliveries.size).to_not eq(1)
    end

    it 'ルートにリダイレクトされないこと' do
      expect(current_path).to_not eq(root_path)
    end

    it '名前のエラーメッセージが表示されること' do
      expect(page).to have_content 'ユーザー名を入力してください'
    end

    it 'メールアドレスのエラーメッセージが表示されること' do
      expect(page).to have_content 'メールアドレスを入力してください'
    end
  end
end
