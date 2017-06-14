class AddAuthorToWikis < ActiveRecord::Migration[5.0]
  def change
    add_column :wikis, :author, :string
  end
end
