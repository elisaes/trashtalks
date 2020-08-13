class List < ApplicationRecord
  attr_accessor :travel_distance, :travel_time
  geocoded_by :address
  after_validation :geocode

  validates :address, :presence => true,
  :length => { :minimum => 10 }
  validates :pickUpDate, :presence => true

  validate :timeslot_cannot_be_in_the_past

  validate :pickupdate_cannot_be_in_the_past

  belongs_to :user
  has_many :types
  accepts_nested_attributes_for :types

  def pickupdate_cannot_be_in_the_past
    if pickUpDate.present? && pickUpDate < Date.today
      errors.add(:pickUpDate, "can't be in the past")
    end
  end  

  def timeslot_cannot_be_in_the_past
    if pickUpDate.present? && pickUpDate == Date.today && timeslot.present? && timeslot.utc.strftime( "%H%M%S%N" ) < Time.now.utc.strftime( "%H%M%S%N" )
      errors.add(:timeslot, "#{Time.now} #{timeslot}" )
    end
  end 

end
