class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :name
      t.text :description
      t.text :department
      t.date :when_to_announce

      t.timestamps
    end
  end
end
