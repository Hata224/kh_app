# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメントのバリデーションについての検証' do
    before do
      @user = FactoryBot.create(:user)
      @comment = @user.comments.create(
        content: 'Hello, world!'
      )
    end
    it 'コメントが空欄であるなら無効であること' do
      @comment.content = nil
      @comment.valid?
      expect(@comment.errors).to be_added(:content, :blank)
    end
  end
end
