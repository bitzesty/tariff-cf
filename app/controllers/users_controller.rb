class UsersController < ApplicationController
  before_filter :authenticate_user!

  def edit
  end

  def update
    params[:user] ||= {}
    password_params = params[:user].symbolize_keys.keep_if { |k, v| [:password, :password_confirmation].include?(k) }
    if current_user.update_attributes(password_params)
      flash[:notice] = t(:updated, :scope => 'devise.passwords')
      sign_in(current_user, :bypass => true)
      redirect_to root_path
    else
      render :edit
    end
  end
end
