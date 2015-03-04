class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :surname
      t.string :first_name
      t.date :birth_date

      t.timestamps
    end
  end
end
