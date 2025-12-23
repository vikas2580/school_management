class CreateStudentBatches < ActiveRecord::Migration[7.2]
  def change
    create_table :student_batches do |t|
      t.references :user, null: false, foreign_key: true
      t.references :batch, null: false, foreign_key: true
      t.integer :progress, default: 0
      t.timestamps
    end
  end
end
