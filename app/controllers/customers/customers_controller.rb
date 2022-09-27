class Customers::CustomersController < Customers::ApplicationController
  # before_action :ensure_guest_user, only: [:edit]

  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
    # @customer = current_customer
    if @customer.email == 'guest@example.com'
    redirect_to root_path
    return
    end
    if @customer == current_customer
    render :edit
    else
    redirect_to mypage_path(current_customer)
    end
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to mypage_path(current_customer)
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :postal_code, :address, :telephone_number, :email)
  end

  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.first_name == "guestcustomer"
      redirect_to customer_path(current_customer), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
