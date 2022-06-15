class RemoveProfileRefFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :profile, foreign_key: true
  end
end
