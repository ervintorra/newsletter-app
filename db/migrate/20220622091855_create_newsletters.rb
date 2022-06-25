class CreateNewsletters < ActiveRecord::Migration[7.0]
  def change
    create_table :newsletters do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :body
      t.datetime :publish_at
      t.boolean :scheduled, default: false
      t.boolean :delivered, default: false

      t.timestamps
    end
  end
end
