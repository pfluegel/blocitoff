class ItemsController < ApplicationController

  

  def index
    @user = current_user#sets @user to use in partails
    @items = Item.all
    authorize @items
  end

  def new
    @item = Item.new
    @user = User.find(params[:user_id])
  end
  
  def create
    @user = User.find(params[:user_id])
    @item = Item.new
    @item.name = params[:item][:name]
    @item.user = @user
    @new_item = Item.new
    authorize @item

    if @item.save
      flash[:notice] = "Item saved"
      
    else
      flash.now[:alert] = "There was a problem saving your item"
      
    end
  
    respond_to do |format| # for ajax
      format.html
      format.js
  end
end
  def destroy
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])
    

    if @item.destroy
      flash[:notice] = "Item deleted"
      
    else
      flash.now[:alert] = "There was a problem deleting your item"
      
    end
    respond_to do |format| # for ajax
      format.html
      format.js
    end
  end

  def destroy_multiple
    @user = User.find(params[:user_id])
    @items = Item.where(id: params[:item_ids])
    if @items.destroy_all
      flash[:notice] = "Items deleted"
      redirect_to :back
    else
      flash[:alert] = "There was a problem deleting your item"
      redirect_to :back
    end
  end
end
