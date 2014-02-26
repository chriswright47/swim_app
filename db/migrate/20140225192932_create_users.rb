class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.boolean :admin, default: false
      t.boolean :coach, default: false
      t.integer :team_id

      t.timestamps
    end

    add_index :users, :email, :unique => true
    add_index :users, :team_id
  end
end
