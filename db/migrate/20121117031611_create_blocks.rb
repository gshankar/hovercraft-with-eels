class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.text  :original
      t.text  :translation
      t.integer :article_id

      t.timestamps
    end
  end
end
