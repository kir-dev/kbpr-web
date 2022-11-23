class PagesController < ApplicationController
  def home
    @articles = Article.order(created_at: :desc)
  end

  before_action :require_admin, only: :admin
  def admin

  end

  before_action :require_login, only: :profile

  def profile
    @user = current_user
  end
end
