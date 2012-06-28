class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def show
    @user = current_user
    @total = @user.sites.sum(:count)
    @max_site = @user.sites.first
  end

  def edit
  end
end
