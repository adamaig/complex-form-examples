class Task < ActiveRecord::Base
  belongs_to :project
  has_many :assignments, :dependent => :destroy
  has_many :steps, :as => 'step_for', :dependent => :destroy
  validates_presence_of :name
  accepts_nested_attributes_for :assignments, :steps, :allow_destroy => true
end
