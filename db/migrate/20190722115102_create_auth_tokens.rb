class CreateAuthTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :auth_tokens do |t|
      t.string :token, unique: true
      t.bigint :expire_time, default: 24.hours.from_now.to_i
      t.boolean :active, default: true
      t.belongs_to :user
      t.timestamps
    end
  end
end
