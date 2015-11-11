class PasswordEditsController < ApplicationController
  def update
    err_msg = validate_before_update(params)
    if err_msg.blank?
      begin
        current_user.update!(password: params[:new_password])
      rescue => e
        binding.pry
        err_msg = e.message
      end
    end

    if err_msg.blank?
      flash.now[:success] = 'パスワードを変更しました'
    else
      flash.now[:alert] =  err_msg
    end
      render 'edit'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def validate_before_update(p)
    target_user = User.authenticate(current_user.email, p[:current_password])
    if target_user.blank?
      '現在のパスワードに誤りが有ります．'
    elsif p[:new_password].blank? || p[:new_password_confirmation].blank?
      '新しいパスワードを入力してください'
    elsif p[:new_password] != p[:new_password_confirmation]
      '新しいパスワードと，確認パスワードが一致しません．'
    else
      nil
    end
  end
end
