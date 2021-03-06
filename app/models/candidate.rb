require 'valid_email'
class Candidate < ActiveRecord::Base
  has_many :proposals
  
  validates :name, presence: true
  validates :about, :length => { :maximum => 500}
  validates :phone, :length => { :is => 13}
  validates :email, :presence => true, :email => true
  validates :site, :blog, :facebook, :twitter, :url => true
end
