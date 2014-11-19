class UserRepository
	BUCKET = 'users'

# sets up our connection to the Riak db
def initialize(client)
	@client = client
end

def all
	user_keys = @client.bucket(BUCKET).keys
	users ||= []
	
	user_keys.each do |key|
		users << find(key)
	end
	users
end

def delete(user)
	@client.bucket(BUCKET).delete(user)
end

def find(key)
	riak_obj = @client.bucket(BUCKET)[key]
	user = User.new
	user.email = riak_obj.data['email']
	user.name = riak_obj.data['name']
	user.password = riak_obj.data['password']
	user.blurb = riak_obj.data['blurb']
	user.follows = riak_obj.data['follows']
	user.followers = riak_obj.data['followers']
	user
end

def save(user)
	users = @client.bucket(BUCKET)
	key = user.email
	
	unless users.exists?(key)
		riak_obj = users.new(key)
		riak_obj.data = user
		riak_obj.content_type = 'application/json'
		riak_obj.store
	end
end

def update(user)
	riak_obj = @client.bucket(BUCKET)[user.email]
	riak_obj.data['name'] = user.name
	riak_obj.data['blurb'] = user.blurb
	riak_obj.data['password'] = user.password
	riak_obj.data['follows'] = user.follows
	riak_obj.data['followers'] = user.followers
	riak_obj.store
end

def show_follows(key)
	@user = find(key)
	@follows = []
	if @user.follows
		@user.follows.each do |following|
			@follows << find(following)
		end
	end
	return @follows
end

def show_followers(key)
	@user = find(key)
	@followers = []
	@user.followers.each do |follower|
		@followers << find(follower)
	end
	return @followers
end

def follow(follower, followed)
	if follower.follows
		follower.follows << followed.email
	else
		follower.follows = [followed.email]
	end
	
	if followed.followers
		followed.followers << follower.email
	else
		followed.followers = [follower.email]
	end
	
	update(follower)
	update(followed)

end

def unfollow(follower, followed)
	follower.follows.delete(followed.email)
	followed.follows.delete(follower.email)
	
	update(followed)
	update(follower)
	
end

end
