class CreateResearches < ActiveRecord::Migration
  def change
    create_table :researches do |t|
      t.integer :lvl
      t.integer :technology_id
      t.integer :user_id
      t.integer :subhouse_id
      t.integer :house_id


      t.timestamps
    end
  end
end
