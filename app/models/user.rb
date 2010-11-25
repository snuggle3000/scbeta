#User
#
#email						string
#first_name				string
#last_name				string
#hashed_password	string
#other_email string
require 'digest'#For Encrypting passwords
class User < ActiveRecord::Base
	attr_accessor :password
	
	belongs_to :couple
	has_one :user
	belongs_to :user
	
	validates :email, :presence => true,
								:uniqueness => true
	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :password, :confirmation => true,
									:length => { :within => 4..20},
									:presence => true,
									:if => :password_required?

	before_save :encrypt_new_password, :clean_formats, :link_couple
	
	
#A process before saving to make accounts seem pretty
	def clean_formats
		self.first_name.capitalize!
		self.last_name.capitalize!
		self.email.capitalize!
		self.other_email.capitalize! if not self.other_email.nil?
	end
	
	def link_couple
		return true if (self.user) and (self.user.user == self)
		return if self.other_email.nil?
		puts "progress"
		other = User.find_by_email(self.other_email)
		return if other.nil?
		puts "progres+1"
		return if other.other_email != self.email
		puts "progress + 3"

		self.user = other
		other.user = self
		couple = Couple.new
		couple.users << self << other
		couple.save
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
