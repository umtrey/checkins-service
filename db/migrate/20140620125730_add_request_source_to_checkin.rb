class AddRequestSourceToCheckin < ActiveRecord::Migration
  def change
    add_column :checkins, :source, :string
  end
end
