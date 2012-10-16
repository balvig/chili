class CreateSocialFeatureLikes < ActiveRecord::Migration
  def change
    create_table :social_feature_likes do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
