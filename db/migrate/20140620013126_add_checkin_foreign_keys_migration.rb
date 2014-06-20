class AddCheckinForeignKeysMigration < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE checkins
        ADD CONSTRAINT fk_checkins_users
        FOREIGN KEY (user_id)
        REFERENCES users(id);
      ALTER TABLE checkins
        ADD CONSTRAINT fk_checkins_locactions
        FOREIGN KEY (location_id)
        REFERENCES locations(id);
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE checkins
        DROP FOREIGN KEY fk_checkins_users;
      ALTER TABLE checkins
        DROP FOREIGN KEY fk_checkins_locations;
    SQL
  end
end
