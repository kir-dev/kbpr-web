class KwcController < ApplicationController
  before_action :require_login, only: [:current, :update]
  before_action :require_admin, only: [:index]
  def current
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(kwc_params)
      redirect_to current_kwc_index_path
    else
      render :show
    end
  end

  def index
    @users = User.all.where(kwc: true).order(:room_number)
  end

  private

  def kwc_params
    params.require(:user).permit(:room_number, :kwc)
  end
end
