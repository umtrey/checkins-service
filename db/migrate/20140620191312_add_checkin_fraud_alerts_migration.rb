class AddCheckinFraudAlertsMigration < ActiveRecord::Migration
  def change
    create_table :checkin_fraud_alerts do |t|
      t.integer :checkin_id, null: false
      t.integer :fraud_alert, null: false
      t.text    :detail

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE checkin_fraud_alerts
        ADD CONSTRAINT fk_checkin_fraud_alerts_checkins_
        FOREIGN KEY (checkin_id)
        REFERENCES checkins(id);
    SQL
  end
end
