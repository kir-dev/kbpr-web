class PagesController < ApplicationController
  def home
    @articles = Article.order(created_at: :desc)
  end

  def admin

  end

  def howto
    
  end

  def profile
    @user = current_user
  end
end
