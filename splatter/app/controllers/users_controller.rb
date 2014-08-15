# Author: Tanvi
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    #render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params(params[:user]))

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params(params[:user]))
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end
  
  # Enable whitelisting for parameter passing
  
  def splatts
		@user = User.find(params[:id])
		render json: @user.splatts
	end
	
	
	
 # Users followed by the indicated user
	def show_follows
		@user = User.find(params[:id])
		render json: @user.follows #who that user follows
	end

 # Method returns a list of followers of a given user
 	def show_followers
		@user = User.find(params[:id])
		render json: @user.followed_by #followers of a given user
	end

 # Add user to list of users followed by user with id
	def add_follows
		#params[:id] is the user who follows
		#params[:follows_id] user to be followed
		
		#make follower
		@follower = User.find(params[:id])
		
		#make followed
		@followed = User.find(params[:follows_id])
		
		#adding to list, follows is a list of user objects
		if @follower.follows << @followed
			head :no_content 
		else
			render json: @follower.errors, status: :unprocessable_entity
		end
	end

 # Delete user id 2 from list of users followed by user id 1
	def delete_follows
	
		#make a follower
		@follower = User.find(params[:id])
		
		#make a followed
		@followed= User.find(params[:follows_id])
		
		#deleting from list
		if @follower.follows.destroy(@followed)
			head :no_content
		else
			render json: @follower.errors, status: :unprocessable_entity
		end
	end
	
	# GET /users/splatts-feed/1
	 def splatts_feed
		@feed = Splatt.find_by_sql("SELECT * FROM splatts JOIN follows ON follows.followed_id = splatts.user_id
								   WHERE follows.follower_id = #{params[:id]} ORDER BY created_at DESC")
		
		 render json: @feed
	 end
	
  private
	def user_params(params)
	params.permit(:email, :password, :name, :blurb)
	end
	
	
 
end
