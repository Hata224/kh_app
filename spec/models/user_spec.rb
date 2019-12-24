# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションについて' do
    before do
      @user = FactoryBot.build(:user)
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

      it 'ユーザー名が50文字を超えると無効であること' do
        @user.username = 'a' * 51
        @user.valid?
        expect(@user.errors[:username]).to include('は50文字以内で入力してください')
      end

      it 'ユーザー名が50文字以内だと有効であること' do
        @user.username = 'a' * 50
        @user.valid?
        expect(@user).to be_valid
      end
    end

    context 'メールアドレスを検証する場合' do
      it 'メールアドレスがなければ無効であること' do
        @user.email = nil
        @user.valid?
        expect(@user.errors[:email]).to include('を入力してください')
      end

      # it '重複したメールアドレスは無効であること' do
      #   @user.valid?
      #   expect(@user.errors[:email]).to include('はすでに存在します')
      # end

      it 'メールアドレスに@が含まれていないなら無効な状態であること' do
        @user.email = 'testexample.com'
        @user.valid?
        expect(@user.errors[:email]).to include('は不正な値です')
      end
    end
  end
end
