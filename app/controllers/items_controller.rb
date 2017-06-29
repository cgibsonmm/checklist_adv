class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy, :complete]
  def index
    if signed_in?
      @items = Item.where(:user_id => current_user.id).order("created_at DESC")
    end
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "Item successfully saved!"
      redirect_to root_path
    else
      flash[:danger] = "Error saving Item!"
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:success] = "Item updated!"
      redirect_to @item
    else
      flash[:danger] = "Error updating item!"
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    flash[:success] = "Item deleted!"
    redirect_to root_path
  end

  def complete
    @item.update_attribute(:completed_at, Time.now)
    redirect_to root_path
  end


  private

    def item_params
      params.require(:item).permit(:title, :description)
    end

    def find_item
      @item = Item.find(params[:id])
    end
end
