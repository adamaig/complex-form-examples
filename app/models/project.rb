class Project < ActiveRecord::Base
  has_many :tasks, :dependent => :destroy
  # has_many :assignments, :dependent => :destroy
  validates_presence_of :name
  accepts_nested_attributes_for :tasks, :allow_destroy => true
end
