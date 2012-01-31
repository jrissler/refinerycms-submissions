class Submission < ActiveRecord::Base

  acts_as_indexed :fields => [:first_name, :last_name, :email, :phone, :message, :your_interest, :how_did_you_find_us, :method_of_contact, :user_ip, :user_agent, :referrer]

  validates :first_name, :presence => true, :uniqueness => true
  
end
