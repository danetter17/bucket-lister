class CreateBucketListItems < ActiveRecord::Migration
  def change
    create_table :bucket_items do |t|
      t.string :content
    end
  end
end
