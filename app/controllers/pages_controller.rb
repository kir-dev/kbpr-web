class PagesController < ApplicationController
  def home
    @articles = Article.order(created_at: :desc)
  end

  before_action :require_admin, only: [:admin, :kwc_list]

  def admin

  end

  def kwc
    @user = current_user
  end

  def kwc_update
    @user = current_user
    if @user.update(kwc_params)
      redirect_to kwc_pages_path
    else
      render :kwc
    end
  end

  def kwc_list
    @users = User.all.where(kwc: true).order(:room_number)
  end

  before_action :require_login, only: :profile

  def profile
    @user = current_user
  end

  private

  def kwc_params
    params.require(:user).permit(:room_number, :kwc)
  end
end
