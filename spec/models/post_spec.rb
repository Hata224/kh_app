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

  it 'ファクトリが有効であること' do
    expect(@post).to be_valid
  end
end
