class KwcsController < ApplicationController
  def current
    @user = current_user
  end

  def update_current
    @user = current_user
    if @user.update(kwc_params)
      redirect_to current_kwcs_path
    else
      render :show
    end
  end

  def index
    @users = User.all.where(kwc: true).order(:room_number)
    @unique_room_count = User.all.where(kwc: true).distinct.count(:room_number)
  end

  def reset
    User.all.where(kwc: true).update(kwc: false)
    redirect_to kwcs_path, notice: 'Szobaszámok sikeresen eltűntetve!'
  end

  private

  def kwc_params
    params.require(:user).permit(:room_number, :kwc)
  end
end
