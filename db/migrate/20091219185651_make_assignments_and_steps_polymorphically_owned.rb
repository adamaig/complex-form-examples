class MakeAssignmentsAndStepsPolymorphicallyOwned < ActiveRecord::Migration
  def self.up
    change_table :steps do |t|
      t.belongs_to :step_for, :polymorphic => true 
    end
    Step.all.each do |step|
      step.step_for = step.assignment
      step.save
    end
    remove_column :steps, :assignment_id
  end

  def self.down
    add_column :steps, :integer, :assignment_id
    Step.all.each do |step|
      if step.step_for.is_a?(Assignment)
        step.assignment = step.step_for
        step.save
      else 
        step.destroy
      end
    end
    remove_column :steps, :step_for_id, :step_for_type
  end
end
