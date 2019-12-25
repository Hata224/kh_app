# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションについての検証' do
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

      it 'メールアドレスに@が含まれていないなら無効な状態であること' do
        @user.email = 'testexample.com'
        @user.valid?
        expect(@user.errors[:email]).to include('は不正な値です')
      end

      it 'メールアドレスが保存される前に小文字に変換されること' do
        @user.email = 'TEST@example.jp'
        @user.save
        expect(@user.email).to eq 'test@example.jp'
      end

      it 'メールアドレスが重複していると登録できないこと' do
        @user.save
        duplicate_user = @user.dup
        duplicate_user.email = @user.email
        expect(duplicate_user).to be_invalid
      end

      it '登録時には、アドレスは小文字で登録されることを確認' do
        mixed_case_email = 'TesT@ExAMPle.CoM'
        @user.email = mixed_case_email
        @user.save
        expect(@user.reload.email).to eq mixed_case_email.downcase
      end
    end

    context 'パスワードについての検証' do
      it 'パスワードがなければ無効であること' do
        @user.password = nil
        @user.valid?
        expect(@user.errors).to be_added(:password, :blank)
      end

      it 'パスワードが6文字未満なら無効であること' do
        @user.password = @user.password_confirmation = 'a' * 5
        @user.valid?
        expect(@user.errors).to be_added(:password, :too_short, count: 6)
      end

      it 'パスワードが6文字以上なら有効であること' do
        @user.password = @user.password_confirmation = 'a' * 6
        @user.valid?
        expect(@user).to be_valid
      end

      it 'パスワードと確認用パスワードが一致していないと無効であること' do
        @user.password = 'password'
        @user.password_confirmation = 'invalid_password'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
      end
    end

    context 'プロフィールについての検証' do
      it 'プロフィール文が500文字以内だと有効であること' do
        @user.profile = 'a' * 500
        expect(@user).to be_valid
      end

      it 'プロフィール文が500文字を超えると無効であること' do
        @user.profile = 'a' * 501
        @user.valid?
        expect(@user.errors).to be_added(:profile, :too_long, count: 500)
      end
    end
  end

  describe 'アカウントを削除すると関連するものも削除されることの検証' do
    it 'アカウントを削除するとユーザーの投稿も削除されること' do
      user1 = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user1)
      expect { user1.destroy }.to change(Post, :count).by(-1)
    end

    it 'アカウントを削除するとフォロー中のユーザーとの関係も削除されることの検証' do
      user1 = FactoryBot.create(:user)
      follower_user = FactoryBot.create(:user, email: 'sample2@example.com')
      follower_user.follow!(user1)
      expect { user1.destroy }.to change(follower_user.followings, :count).by(-1)
    end

    it 'アカウントを削除するとフォロワーとの関係も削除されること' do
      user1 = FactoryBot.create(:user)
      follower_user = FactoryBot.create(:user, email: 'sample3@example.com')
      follower_user.follow!(user1)
      expect { user1.destroy }.to change(follower_user.followings, :count).by(-1)
    end
  end
end
