class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:edit, :show]
 
  def index
    @prototype = Prototype.all #includes(:user).order("created_at DESC") 
  end

  def new
    @prototype = Prototype.new
  end

  def create
    #Prototype.create(prototype_params)
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    #@comment = Comment.find(params[:id])
    @comments = @prototype.comments.includes(:user)
  end

  def edit 
      unless current_user.id == @prototype.user.id
        redirect_to action: :index
      end
  end

  def update
    @prototype = Prototype.find(params[:id])
     if @prototype.update(prototype_params)
      redirect_to action: :show
     else
      render :edit
     end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    @prototype = Prototype.all
    render :index
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :image, :catch_copy, :concept).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
