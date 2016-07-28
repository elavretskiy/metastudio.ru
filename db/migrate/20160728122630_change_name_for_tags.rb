class ChangeNameForTags < ActiveRecord::Migration
  def change
    change_column :tags, :name, :string, null: false
  end
end
