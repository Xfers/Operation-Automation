class ChangeColumnDateToDatetime < ActiveRecord::Migration[7.0]
  def change
    change_column :messages, :target_announce_date, :datetime
    add_column :messages, :approval, :string
    add_column :messages, :target_announce_time, :datetime
  end
end
