class Country < ActiveRecord::Base
  has_many :clients
end
