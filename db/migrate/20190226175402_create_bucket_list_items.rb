class CreateBucketListItems < ActiveRecord::Migration
  def change
    create_table :bucket_list_items do |t|
     t.string :content
     t.integer :user_id
    end
  end
end
