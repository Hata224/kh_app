# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @post = @user.posts.create(
      title: 'test',
      body: 'Hello, world！',
      created_at: Time.zone.now,
      user: @user
    )
  end

  it 'タイトルと本文が有効であること' do
    expect(@post).to be_valid
  end

  describe '投稿のバリデーションについて' do
    it 'タイトルがなければ無効であること' do
      @post.title = nil
      @post.valid?
      expect(@post.errors[:title]).to include('を入力してください')
    end

    it 'タイトルが50文字以上であるなら無効であること' do
      @post.title = 'a' * 51
      @post.valid?
      expect(@post.errors).to be_added(:title, :too_long, count: 50)
    end

    it '本文が1000文字以内だと有効であること' do
      @post.body = 'a' * 1000
      expect(@post).to be_valid
    end

    it '本文が1000文字を超えると無効であること' do
      @post.body = 'a' * 1001
      @post.valid?
      expect(@post.errors).to be_added(:body, :too_long, count: 1000)
    end

    it '投稿にuser_idがなければ無効であること' do
      @post = Post.create(user_id: nil)
      @post.valid?
      expect(@post.errors[:title]).to include 'を入力してください'
    end
  end

  describe 'その他' do
    it '新しい順に並んでいること' do
      FactoryBot.create(:post, user: @user, created_at: 10.minutes.ago)
      FactoryBot.create(:post, user: @user, created_at: 3.years.ago)
      FactoryBot.create(:post, user: @user, created_at: 2.hours.ago)
      expect(@post).to eq Post.first
    end
  end
end
