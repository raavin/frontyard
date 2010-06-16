class WaitingList < ActiveRecord::Base
  belongs_to :service
  belongs_to :client
  belongs_to :category
end
