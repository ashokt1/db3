class User < ActiveRecord::Base

#Performing validations
validates :name, presence: true
validates :email, uniqueness: { case_sensitive: false}
validates :password, length: {minimum: 8}, if: :strong?

def strong?
	password =~ /.*\d+.*/ && \
	password =~ /.*[a-z]+.*/ && \
	password =~ /.*[A-Z].*/
end

has_many :splatts

has_and_belongs_to_many :follows,
	class_name: "User",
	join_table: :follows,
	foreign_key: :follower_id,
	association_foreign_key: :followed_id
	
	#u1.follows returns a list of users followed by u1
	#u1.follows << u2 adds u2 to u1's list of followed users
	#u1.follows.delete(u2) removes u2 from u1's list

	has_and_belongs_to_many :followed_by,
		class_name: "User",
		join_table: :follows,
		foreign_key: :followed_id,
		association_foreign_key: :follower_id
end
