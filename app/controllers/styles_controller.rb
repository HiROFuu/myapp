class StylesController < ApplicationController
  def new
    @style = Style.new
  end
  
  def create
    @style = Style.new(style_params)
    if @style.save
      redirect_to styles_path, success: '画像登録に成功しました'
    else
      flash.now[:danger] = "失敗しました"
      render :new
    end
  end
  
  def edit
  end
  
  def index
    @styles = Style.all
  end
  
  def destroy
    Style.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to styles_url
  end
  
  private
  
  def style_params
    params.require(:style).permit(:image, :name)
  end
end
