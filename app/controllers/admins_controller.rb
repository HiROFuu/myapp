class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  before_action :admin_user

  # GET /admins
  # GET /admins.json
  # def index
  #   @admins = Admin.all
  # end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  # EventNEWはアドミンだけができるようにしたい
  def eventnew
    @event = Event.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def eventcreate
   @event = Event.new(event_params)
      if @event.save
        # format.html { redirect_to @event, notice: '展覧会情報の登録が完了しました' }
        # format.json { render :show, status: :created, location: @event }
        redirect_to events_path, success: '展覧会情報の登録が完了しました'
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
  end
    
  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
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
    @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
    end
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
    
    def set_event
      @event = Event.find(params[:id])
    end
    
    def event_params
      params.require(:event).permit(:name, :from_date, :to_date, :from_time, :to_time, :prefecture, :price, :style, :link_url, :count_works, :discription, :style_id)
    end
end