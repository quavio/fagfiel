class AddDeviseInvitable < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string   :invitation_token, :limit => 60
      t.datetime :invitation_sent_at
      t.confirmable
      t.index    :invitation_token
    end

    # Allow null encrypted_password
    change_column_null :users, :encrypted_password, true
  end

  def self.down
    change_column_null :users, :encrypted_password, false
    remove_column :users, :invitation_token
    remove_column :users, :invitation_sent_at
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_token
    remove_column :users, :confirmation_sent_at
  end
end
