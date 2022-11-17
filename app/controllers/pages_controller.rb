class PagesController < ApplicationController
  def home
    @articles = Article.order(created_at: :desc)
  end
end
