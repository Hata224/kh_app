# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @post = @user.posts.create(
      title: 'test',
      body: 'Hello, world！'
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

    it '本文がなければ無効であること' do
      @post.body = nil
      @post.valid?
      expect(@post.errors[:body]).to include('を入力してください')
    end

    it '投稿にuser_idがなければ無効であること' do
      @post = Post.create(user_id: nil)
      @post.valid?
      expect(@post.errors[:title]).to include 'を入力してください'
    end
  end
end
