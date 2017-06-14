class CreateCollaborators < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborators do |t|
      t.integer :wiki_id, index: true
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
