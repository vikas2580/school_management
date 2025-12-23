class CreateEnrollmentRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :enrollment_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :batch, null: false, foreign_key: true
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
