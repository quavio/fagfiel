class AlterResellersAlterCreditsAndDebits < ActiveRecord::Migration
  def self.up
    execute "
    ALTER TABLE resellers ALTER credits TYPE integer;
    ALTER TABLE resellers ALTER debits TYPE integer;
    "
  end

  def self.down
    execute "
    ALTER TABLE resellers ALTER credits TYPE numeric;
    ALTER TABLE resellers ALTER debits TYPE numeric;
    "
  end
end
