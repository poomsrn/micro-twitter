class User < ApplicationRecord
	has_many :posts
	has_secure_password
	validates_confirmation_of :password
	has_many :followee_members, class_name: "Follow", foreign_key: "follower_id"
	has_many :follower_members, class_name: "Follow", foreign_key: "followee_id"
	has_many :followers, through: "follower_members"
	has_many :followees, through: "followee_members"
	has_many :like_users, class_name: "Like", foreign_key: "user_id"
	validates :email,:name,uniqueness:true
	validates :email,:name,:password,presence:true
	# validate :validate_email, on: [:create]
	validate :validate_login, on: [:login]
	# def validate_email
	# 	@user = User.find_by(email:self.email)
	# 	if(@user)
	# 		errors.add(:email,message:"This email name already used !.")
	# 	end
	# end
	def validate_login
		@user = User.find_by(email:self.email)
		if (@user && @user.authenticate(self.password))
			return self.id = @user.id
		else
			errors.add(:email,message:"Invalid email or password !!.")
			errors.add(:password,message:"Invalid email or password !!.")
			return false
		end
	end
	def get_feed_post(user_id)
	    ids = Follow.where(follower_id: user_id).pluck('followee_id')
	    ids.push(user_id)
	    return ids
  	end
end
