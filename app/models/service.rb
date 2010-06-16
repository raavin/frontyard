class Service < ActiveRecord::Base
  
  validates_presence_of :service_name, :min_age, :max_age
  validates_uniqueness_of :service_name
  
  has_many :messages
  has_many :case_notes
  has_many :waiting_lists
end
