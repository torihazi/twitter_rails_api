class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.string :content, limit: 150
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
