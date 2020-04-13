class FavoritesController < ApplicationController

  # GET /favorites
  # GET /favorites.json
  def index
    @favorite_posts = current_user.favorite_posts
  end

  # GET /favorites/1
  # GET /favorites/1.json
  def show
    @favorites_count = Favorite.where(post_id: @post.id).count
  end

  # GET /favorites/new
  def new
    @favorite = Favorite.new
  end

  # GET /favorites/1/edit
  def edit
  end

  # POST /favorites
  # POST /favorites.json
  def create
    favorite = Favorite.new
        favorite.user_id = current_user.id
        favorite.post_id = params[:post_id]
    
        if favorite.save
          redirect_to posts_path, success: 'お気に入りに登録しました'
        else
          redirect_to posts_path, danger: 'お気に入りに登録に失敗しました'
        end
  end

  # PATCH/PUT /favorites/1
  # PATCH/PUT /favorites/1.json
  def update
    respond_to do |format|
      if @favorite.update(favorite_params)
        format.html { redirect_to @favorite, notice: 'Favorite was successfully updated.' }
        format.json { render :show, status: :ok, location: @favorite }
      else
        format.html { render :edit }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
    @favorite.destroy
    redirect_to posts_path, success: 'いいねを取り消しました'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:post_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favorite_params
      params.require(:favorite).permit(:user_id, :post_id)
    end
end
