class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :details
      t.boolean :buy
      t.boolean :sell
      t.boolean :rent
      t.boolean :price_eval
      t.boolean :options_eval

      t.timestamps
    end
  end
end
