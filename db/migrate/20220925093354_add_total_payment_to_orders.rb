class AddTotalPaymentToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :total_payment, :integer
  end
end
