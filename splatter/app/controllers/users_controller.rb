# Author: Tanvi
class UsersController < ApplicationController
before_filter :set_headers
  # GET /users
  # GET /users.json
  def index
	db = UserRepository.new(Riak::Client.new)
    @users = db.all

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
	db = UserRepository.new(Riak::Client.new)
	@user = db.find(params[:id])
	render json: @user
  end
 
  # POST /users
  # POST /users.json
  def create
	@user = User.new
	@user.email = params[:user][:email]
	@user.name = params[:user][:name]
	@user.password = params[:user][:password]
	@user.blurb = params[:user][:blurb]
	
	db = UserRepository.new(Riak::Client.new)
	if db.save(@user)
		render json: @user, status: :created, location: @user
	else
		render json: "error", status: :unprocessable_entity
	end
end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # @user = User.find(params[:id])

    # if @user.update(user_params(params[:user]))
      # head :no_content
    # else
      # render json: @user.errors, status: :unprocessable_entity
    # end
	
	#initialising the user repository class
	db = UserRepository.new(Riak::Client.new) 
	@user = db.find(params[:id])
	@user.name = params[:name]
	@user.blurb = params[:blurb]
	@user.password = params[:password]
	
	db.update(@user)
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # @user = User.find(params[:id])
    # @user.destroy

    # head :no_content
	db = UserRepository.new(Riak::Client.new)
	@user = db.find(params[:id])
	
	db.delete(@user)
	
  end
  
  # Enable whitelisting for parameter passing
  
  def splatts
		# @user = User.find(params[:id])
		# render json: @user.splatts
		
		db = UserRepository.new(Riak::Client.new)
		@user = db.find(params[:id])
		
		db = SplattRepository.new(Riak::Client.new, @user)
		render json: db.all
  end
	
	
 # Users followed by the indicated user
	def show_follows
		# @user = User.find(params[:id])
		# render json: @user.follows #who that user follows
		db = UserRepository.new(Riak::Client.new)
		@user = db.find(params[:id])
		# render json: @user.follows
	end

 # Method returns a list of followers of a given user
 	def show_followers
		# @user = User.find(params[:id])
		# render json: @user.followed_by #followers of a given user
		db = UserRepository.new(Riak::Client.new)
		#@followed = db.find(params[:id])
		@followers = db.show_followers(params[:id])
		render "show_followers"
	end

	#POST /users/follows
 # Add user to list of users followed by user with id
	def add_follows
		
		
		db = UserRepository.new(Riak::Client.new)
		@follower = db.find(params[:id])
		@followed = db.find(params[:follows_id])
		
		if db.follow(@follower, @followed)
			@follows = db.show_follows(params[:id])
			render "show_follows"
		else
			render json: "error saving follow relationship", status: :unprocessable_entity
		end
	end

 # Delete user id 2 from list of users followed by user id 1
	def delete_follows
	
		#make a follower
		# @follower = User.find(params[:id])
		
		#make a followed
		# @followed= User.find(params[:follows_id])
		
		#deleting from list
		# if @follower.follows.destroy(@followed)
			# head :no_content
		# else
			# render json: @follower.errors, status: :unprocessable_entity
		# end
		
		db = UserRepository.new(Riak::Client.new)
		@follower = db.find(params[:id])
		@followed = db.find(params[:follows_id])
		
		if db.follow.delete(@follower, @followed)
			head :no_content
		else
			render json: "error deleting unfollow relationship", status: :unprocessable_entity
		end	
	end
	
	# GET /users/splatts-feed/1
	  def splatts_feed
		@feed = Splatt.find_by_sql("SELECT * FROM splatts JOIN follows ON follows.followed_id = splatts.user_id
								   # WHERE follows.follower_id = #{params[:id]} ORDER BY created_at DESC")
		
		 render json: @feed
	  end
	
  private
	def user_params(params)
	params.permit(:email, :password, :name, :blurb)
	end
	
	def set_headers
	headers['Access-Control-Allow-Origin'] = '*';
	end	

end
