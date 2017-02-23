class Meetup < ActiveRecord::Base
  has_many :participants
  has_many :users, through: :participants

  validates :name, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :email, presence: true
end
