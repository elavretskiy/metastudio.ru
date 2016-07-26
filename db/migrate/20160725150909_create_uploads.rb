class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.attachment :file

      t.timestamps
    end

    add_column :uploads, :object_id, :integer, null: false
    add_column :uploads, :object_type, :string, null: false
  end
end
