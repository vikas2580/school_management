class CreateSchools < ActiveRecord::Migration[7.2]
  def change
    create_table :schools do |t|
      t.string :name
      t.text :description
      t.references :created_by, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
