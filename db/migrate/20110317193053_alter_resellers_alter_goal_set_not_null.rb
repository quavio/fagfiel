class AlterResellersAlterGoalSetNotNull < ActiveRecord::Migration
  def self.up
    execute "
    ALTER TABLE resellers ALTER goal SET NOT NULL;
    ALTER TABLE resellers ALTER goal SET DEFAULT 7500;
    "
  end

  def self.down
    execute "
    ALTER TABLE resellers ALTER goal DROP NOT NULL;
    ALTER TABLE resellers ALTER goal DROP DEFAULT;
    "
  end
end
