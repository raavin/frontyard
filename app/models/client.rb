class Client < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :first_name, :last_name, :dob, :scope => [:first_name, :last_name, :dob], :message => "- It seems you are duplicating a client" 
  
  belongs_to :country
  
  has_many :waiting_lists
  belongs_to :case_note
end
