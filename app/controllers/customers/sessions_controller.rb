class Customers::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]

  def new
    @customer = Customer.new
  end

  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to items_path, notice: 'ゲストでログインしました。'
  end

  protected
  # 退会しているかを判断するメソッド
  def customer_state
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @customer.valid_password?(params[:customer][:password])
      ## 【処理内容3】
      if @customer.is_deleted == true
        redirect_to new_customer_registration_path
      end
    end
  end
end