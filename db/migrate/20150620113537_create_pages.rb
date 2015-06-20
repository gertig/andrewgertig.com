class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :user, index: true
      t.string :slug, index: true
      t.text :content
      t.boolean :published, default: false
      t.text :meta_description
      t.datetime :published_at

      t.timestamps
    end
  end
end
