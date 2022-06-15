class RemoveCommentRefFromTasks < ActiveRecord::Migration[6.0]
  def change
    remove_reference :tasks, :comment, foreign_key: true
  end
end
