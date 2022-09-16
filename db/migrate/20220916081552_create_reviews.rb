class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :title 
      t.text :body
      t.integer :rating 
      t.references :reviewable, polymorphic: true
      t.timestamps
    end
  end
end
