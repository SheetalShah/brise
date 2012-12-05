module UsersHelper
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def is_correct_user(user_to_check)
    @user = User.find(user_to_check)
    current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def product_name(product_id)
    Product.find(product_id)
  end
end
