class ChangeWhenToAnnounceToAnnounceTime < ActiveRecord::Migration[7.0]
  def change
    change_column :messages, :when_to_announce, :date
    rename_column :messages, :when_to_announce, :target_announce_date
  end
end
