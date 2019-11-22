# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :sign_in_required, only: [:show]
  def index; end

  def show; end
end
