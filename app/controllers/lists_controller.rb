class ListsController < ApplicationController
  before_action :authenticate_user!
  def index
    @lists = List.all
  end

  def new
    @list = List.new
    type = @list.types.build
  end

  def create 
    @list = List.new(list_params)
    @list.status = 0
    @list.user = current_user

    if @list.save
      flash[:notice] = "List successfully created!🎉"
      redirect_to user_path(current_user.id)
    else 
      flash[:alert] = "Uh oh! Something went wrong, please try again later 😔"
      render :new
    end 
  end 

  def edit 
    @list = List.find(params[:id])
  end 

  def update 
    @list = List.find(params[:id])

    # remove everything in the current list
    @list.types.each do |type|
      type.destroy
    end 

    # rebuild everything
    if @list.update(list_params)
      flash[:notice] = "List successfully updated!🎉"
      redirect_to list_path(@list)
    else 
      render :edit
    end 
  end 

  def show # individual List pages
    @list = List.find(params[:id])

    if @list.collector != nil # if the list is being collected
      # we find the name and display it
      @assigned = User.find(@list.collector).username
    end 
  end

  def assign # the collector has clicked to assign this task to themselves
    list = List.find(params[:id])
    list.collector = current_user.id
    list.update(status: 1) # 0 - unfulfilled, 1 - doing, 2 - done
    if list.save 
      flash[:notice] = "List successfully assigned!🎉"
      redirect_to user_path(current_user.id)
    else 
      flash[:alert] = "Uh oh! Something went wrong, please try again later 😔"
    end
  end 

  def complete
    list = List.find(params[:id])
    list.update(status: 2) 
    if list.save 
      flash[:notice] = "Thank you for saving Mother Earth! You deserve a trophy!🏆"
      redirect_to user_path(current_user.id)
    end 
  end 

  def destroy 
    # delete all dependencies
    List.find(params[:id]).types.each do |type|
      type.destroy
    end 

    # delete the lists
    if List.find(params[:id]).destroy
      flash[:notice] = "List successfully deleted."
      redirect_to user_path(current_user.id)
    else 
      flash[:alert] = "Uh oh! Something went wrong, please try again later 😔"
    end 
  end 

  private
  
  def list_params
    params.require(:list).permit(:address, :pickUpDate, :remarks, :timeslot ,types_attributes: [:material, :remarks, :weight])
  end

end
