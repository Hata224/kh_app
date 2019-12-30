require 'rails_helper'

RSpec.feature 'Pages', type: :feature do
  describe 'トップページ' do
    before do
      visit root_path
    end

    it 'Homeにクラコピと表記されていること' do
      expect(page).to have_content 'クラコピ'
    end

    context 'ヘッダーに関する検証' do
      it 'ヘッダーに「ログイン」の項目があること' do
        expect(page).to have_content 'ログイン'
      end

      it 'ヘッダーに「新規登録」の項目があること' do
        expect(page).to have_content '新規登録'
      end
    end
  end
end
