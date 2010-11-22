class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.String :email
      t.String :first_name
      t.String :last_name
      t.String :hashed_password
      t.String :other_email

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
