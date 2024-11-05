class AddSaleStatusToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :sale_status, :integer, default: 0 # 0: 販売中, 1: 売却済み
  end
end
