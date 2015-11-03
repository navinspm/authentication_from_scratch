require 'digest/md5'
require 'base64'
require 'securerandom'

class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessor :password_confirmation
	validates_presence_of :password, :on => :create
	validates_presence_of :user_name
	validates_uniqueness_of :user_name
	before_save :encrypt_password
    before_save :validates_confirmation
	
	def validates_confirmation
	   if self.password != self.password_confirmation
	   	   self.errors.add(:base, "password & password_confirmation not mathches")
	   	   return false
       end
	end

	def self.authenticate(user_name,password)
		user = find_by_user_name(user_name)
		if user && user.password_hash == Digest::MD5.hexdigest(password + user.password_salt)
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = SecureRandom.hex
			self.password_hash = Digest::MD5.hexdigest(self.password + password_salt)
		end
	end
end
