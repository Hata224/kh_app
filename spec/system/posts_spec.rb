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

    context '有効な入力をしたとき' do
      before { visit new_post_path }
      # it '投稿成功のメッセージが表示される' do
      #   fill_in post[title], with: 'test'
      #   fill_in '依頼の詳細', with: 'test123'
      #   attach_file '画像', ''
      #   click_button '投稿する'
      #   expect(page).to have_content('投稿しました')
      # end
    end
    # context '無効な入力をしたとき' do
    #   before { visit new_post_path }
    #   it '投稿失敗のメッセージが表示されること' do
    #     click_button '投稿する'
    #     expect(page).to have_content('投稿に失敗しました')
    #   end
    # end
  end
end
