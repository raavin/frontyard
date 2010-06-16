class CaseNote < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  belongs_to :client
end
