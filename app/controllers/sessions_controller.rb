class SessionsController < ApplicationController
  def new
  end

  # def create
  #   auth = request.env['omniauth.auth']
  #     if auth.present?
  #       user = User.find_or_create_from_auth(request.env['omniauth.auth'])
  #       session[:user_id] = user.id
  #       flash[:success] = "ユーザー認証が完了しました。"
  #       redirect_to user
  #     else
  #       user = User.find_by(email: params[:session][:email].downcase)
  #       if user && user.authenticate(params[:session][:password])
  #         if user.activated?
  #           log_in user
  #           params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  #           redirect_back_or user
  #         else
  #           message  = "会員登録が完了していません"
  #           message += "登録されたメールをご確認いただき、会員登録を完了させてください。"
  #           flash[:warning] = message
  #           redirect_to root_url
  #         end
  #       else
  #       flash.now[:danger] = 'メールアドレスとパスワードが一致していません'
  #       render 'new'
  #       end
  #     end
  # end
  
  def t_create
    @user = User.find_or_initialize_from_auth(request.env['omniauth.auth'])
    @user.save
    session[:user_id] = @user.id
    if session[:user_id]
      flash[:success] = "ユーザー認証が完了しました。"
      redirect_to @user
    else
      flash[:danger] = "ユーザー認証に失敗しました。"
      redirect_to root_url
    end
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "会員登録が完了していません"
        message += "登録されたメールをご確認いただき、会員登録を完了させてください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
    flash.now[:danger] = 'メールアドレスとパスワードが一致していません'
    render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
