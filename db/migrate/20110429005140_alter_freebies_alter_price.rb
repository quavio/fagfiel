class AlterFreebiesAlterPrice < ActiveRecord::Migration
  def self.up
    execute "
    ALTER TABLE freebies ALTER price TYPE integer;
    ALTER TABLE courses ALTER price TYPE integer;
    "
  end

  def self.down
    execute "
    ALTER TABLE freebies ALTER price TYPE numeric;
    ALTER TABLE courses ALTER price TYPE numeric;
    "
  end
end
