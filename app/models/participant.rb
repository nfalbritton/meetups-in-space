class Participant < ActiveRecord::Base
  belongs_to :meetup
  belongs_to :user

  validates :user_id, presence: true
  validates :meetup_id, presence: true
end 
