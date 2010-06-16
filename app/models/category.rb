class Category < ActiveRecord::Base
  has_many :waiting_lists
end
