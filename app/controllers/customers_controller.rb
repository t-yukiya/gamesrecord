class CustomersController < ApplicationController
  def index
    @customers = Customer.all
    @customer = current_customer
    @post = Post.new
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @following_customers = @customer.following_customers
    @follower_customers = @customer.follower_customers
    @post = Post.new
  end

  def edit
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to customer_path(current_customer.id)
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
  
  def follows
    customer = Customer.find(params[:id])
    @customer = customer.following_customers
  end

  def followers
   customer = Customer.find(params[:id])
    @customer = customer.follower_customers
  end

  
  private
  def customer_params
    params.require(:customer).permit(:name, :introduction)
  end
end
