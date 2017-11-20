class SearchController < ApplicationController
  def index
  end

  def create
  	@user = User.find(params[:id])
  	render json: @user 
  end

end
