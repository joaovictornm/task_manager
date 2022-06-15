class RemoveCommentRefFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :comment, foreign_key: true
  end
end
