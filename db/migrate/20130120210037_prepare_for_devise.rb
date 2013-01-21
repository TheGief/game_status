class PrepareForDevise < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :password_digest
      t.change :username, :string, after: :id
      t.change :phone, :string, after: :email
    end
  end
end
