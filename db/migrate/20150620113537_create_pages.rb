class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :user, index: true
      t.string :slug
      t.text :content
      t.boolean :published
      t.text :meta_description
      t.datetime :published_at

      t.timestamps
    end
  end
end
