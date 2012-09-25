class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, default: 'Bob'
      t.boolean :admin
      t.timestamps
    end
  end
end
