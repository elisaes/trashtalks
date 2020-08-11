require 'net/http'
require "uri"

class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user, only: [:index]

  def index # landing page when users login, => shows all the lists
    if (current_user.role === "user") # user is a collector

      # show lists with accordance to distance whereby status is either open or assigned i.e. not completed
      @lists = List.near(current_user.address, 999999, order: 'distance', units: :km).where("STATUS != 2")

      @lists.each do |li|
        # details = get_travel_time(li.latitude, li.longitude)
        li.travel_distance = "10"
        li.travel_time = "20"
      end 

      # respond_to do |format|
      #   format.html # index.html.erb
      #   format.xml  { render :xml => @lists}
      # end 
    else 
      # if the user is an admin/ regular user, just show all lists
      @lists = List.near(current_user.address, 999999, order: 'distance', units: :km)

      @lists.each do |li|
        def li.travel_distance
          "10"
        end 
        def li.travel_duration
          "100"
        end 
      end 
    end
  end

  def show # show user's dashboards
    @user = User.find(params[:id])

    # initialise
    lists = Array.new
    @in_progress = Array.new
    @completed = Array.new

    # if the user is a collector
    if @user.role === "user"
      # find all the Lists where the user is a collector
      lists = List.where(collector: @user.id)
    elsif @user.role === "recycler"
      lists = User.find(@user.id).lists
    else # this person is an admin, just display everything
      lists = List.all
    end 

    # we filter the lists to completed and in_progress
    lists.each do |list|
      if list.status === 1 || list.status === 0 then @in_progress << list
      else @completed << list
      end 
    end 

  end 

  private
  
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:fname, :lname, :desc, :username, :password,:email, :phone, :address, :city, :country)
  end

  def get_travel_time(lat, lng)
    puts "google"
    uri = URI.parse("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{current_user.latitude},#{current_user.longitude}&destinations=#{lat},#{lng}&key=#{ENV['GOOGLE_API_KEY']}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(req)
    return JSON.parse(response.body)["rows"][0]["elements"][0]
  end 

end
