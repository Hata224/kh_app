# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションについて' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'ユーザー名、メールアドレス、パスワードが有効であること' do
      expect(@user).to be_valid
    end

    context 'ユーザー名を検証する場合' do
      it 'ユーザー名がなければ無効であること' do
        @user.username = nil
        @user.valid?
        expect(@user.errors[:username]).to include('を入力してください')
      end
    end
  end
end
