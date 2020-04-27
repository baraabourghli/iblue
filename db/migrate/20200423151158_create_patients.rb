class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.decimal :score
      t.text :severity
      t.integer :pulse
      t.integer :age
      t.integer :respiratory

      t.timestamps
    end
  end
end
