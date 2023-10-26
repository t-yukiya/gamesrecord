class CustomersController < ApplicationController
  def index
    @customers = Customer.all
    @customer = current_customer
    @post = Post.new
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def edit
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to cusotmer_path(current_customer.id)
    end
    @customer = Customer.find(params[:id])
  end
  
  def update
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to customer_path(current_customer.id)
    end
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end
  
  private
  def customer_params
    params.require(:customer).permit(:name, :introduction)
  end
end
