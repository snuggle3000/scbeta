require 'digest'#For Encrypting passwords
class User < ActiveRecord::Base
	attr_accessor :password

#A process before saving to make accounts seem pretty
	def clean_formats
		self.first_name.capitalize!
		self.last_name.capitalize!
		self.city.capitalize!
		self.email.capitalize!
	end
	
	#Checks for a match for logging in
	def self.authenticate(email, password)
		email.downcase!
		user = find_by_email(email)
		if user.nil?
			user = find_by_email(email.capitalize!)
		end
		return user if user && user.authenticated?(password)
	end
	
	#checks of the password is correct
	def authenticated?(password)
		self.hashed_password == encrypt(password)
	end
	
	#Deals with the generation of a new password
	protected
		def encrypt_new_password
			return if password.blank?
			self.hashed_password = encrypt(password)
		end
	
		def password_required?
			hashed_password.blank? || password.present?
		end
	
		def encrypt(password)
			Digest::SHA1.hexdigest(password)
		end
end
