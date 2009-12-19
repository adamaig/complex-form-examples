class Step < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :step_for, :polymorphic => true
end
