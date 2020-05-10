class AdminsController < ApplicationController
  before_action :set_adminevent, only: [:show, :eventedit, :eventupdate, :eventdestroy]
  before_action :set_admincontact, only: [:show, :contactedit, :contactupdate, :contactdestroy]
  before_action :admin_user

  # GET /admins
  # GET /admins.json
  def eventindex
    @search_params = event_search_params
    @events = Event.search(@search_params).where('to_date >= ?', Date.today)
    @events_counts = @events.count
    if @search_params.blank?
      @events = Event.all.where('to_date >= ?', Date.today).order(:to_date).kaminari_page(params[:page]).per(10)
      render action: :eventindex
    else
      @events = Event.search(@search_params).where('to_date >= ?', Date.today).order(:to_date).kaminari_page(params[:page]).per(10)
      render action: :eventindex
    end
  end
  
  def postindex
    @posts = Post.all.includes(:favorite_users, :comment_users)
  end
  
  def eventimageindex
    @eventimages = Eventimage.all
  end
  
  def contactindex
    @contacts = Contact.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  # EventNEWはアドミンだけができるようにしたい
  def eventnew
    @event = Event.new
  end
  
  def eventimagenew
    @eventimage = Eventimage.new
  end

  # GET /admins/1/edit
  def edit
  end
  
  def postedit
  end
  
  def eventedit
  end
  
  def contactedit
    @contact = Contact.find(params[:id])
  end
  
  # POST /admins
  # POST /admins.json
  def eventcreate
   @event = Event.new(event_params)
      if @event.save
        redirect_to admins_eventsindex_path, success: '展覧会情報の登録が完了しました'
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
  end
  
  def eventimagecreate
    @eventimage = Eventimage.new(eventimage_params)

    if @eventimage.save
      redirect_to admins_eventimagesindex_path, success: '展覧会画像の登録に成功しました'
    else
      flash.now[:danger] = "失敗しました"
      render :new
    end
  end
    
  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def eventupdate
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def contactupdate
      if @contact.update(contact_params)
        redirect_to admins_contactsindex_path, notice: 'Contact was successfully updated.'
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
  end
  

  # DELETE /admins/1
  # DELETE /admins/1.json
  # def post_destroy
  #   @admin.destroy
  #   respond_to do |format|
  #     format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  
  def eventdestroy
     Event.find(params[:id]).destroy
      flash[:success] = "削除しました"
      redirect_to admins_eventsindex_url
  end
  
  def eventimagedestroy
      Eventimage.find(params[:id]).destroy
      flash[:success] = "削除しました"
      redirect_to admins_eventimagesindex_url
  end
    
  def postdestroy
      Post.find(params[:id]).destroy
       flash[:success] = "削除しました"
       redirect_to admins_postsindex_url
  end
  
  def contactdestroy
      Contact.find(params[:id]).destroy
       flash[:success] = "削除しました"
       redirect_to admins_contactsindex_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.fetch(:admin, {})
    end
    
    def set_adminevent
      @event = Event.find(params[:id])
    end
    
    def set_admincontact
      @contact = Contact.find(params[:id])
    end
    
    def event_params
      params.require(:event).permit(:name, :from_date, :to_date, :from_time, :to_time, :prefecture, :price, :style, :link_url, :count_works, :discription, :style_id, :eventimage_id)
    end
    
    def event_search_params
    params.fetch(:search, {}).permit(:name, :from_date, :prefecture, :style_id)
    end
    
    def contact_params
      params.require(:contact).permit(:name, :email, :category, :content, :status)
    end
    
    def eventimage_params
      params.require(:eventimage).permit(:image, :name)
    end
end