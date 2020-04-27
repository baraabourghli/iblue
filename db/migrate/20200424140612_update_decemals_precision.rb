class UpdateDecemalsPrecision < ActiveRecord::Migration[5.0]
  def change
    change_column :patients, :score, :decimal, precision: 5, scale: 2
  end
end
