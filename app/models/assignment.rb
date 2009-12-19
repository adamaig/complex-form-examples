class Assignment < ActiveRecord::Base
  belongs_to :task
  has_many :steps, :as => 'step_for', :dependent => :destroy
  validates_presence_of :owner
  accepts_nested_attributes_for :steps, :allow_destroy => true
end
