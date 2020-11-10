class UsersController < ApplicationController
  def show
    #@comment = Comment.find(params[:id])
    #@user = User.where(comment_id: @comment)
    @user = User.find(params[:id])
    @name = @user.name
    @prototype = @user.prototypes
  end
end
