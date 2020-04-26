class EventsController < ApplicationController
  include EventsHelper
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  require 'date'

  # GET /events
  # GET /events.json　
  def index
    @search_params = event_search_params
    @events = Event.search(@search_params).where('to_date >= ?', Date.today)
    @events_counts = @events.count
    if @search_params.blank?
      @events = Event.all.where('to_date >= ?', Date.today).order(:to_date).kaminari_page(params[:page]).per(10)
    else
      @events = Event.search(@search_params).where('to_date >= ?', Date.today).order(:to_date).kaminari_page(params[:page]).per(10)
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  # イベントNEWはアドミンだけにさせたい
  # def new
  #   @event = Event.new
  # end

  # GET /events/1/edit
  # def edit
  # end

  # # POST /events
  # # POST /events.json
  # def create
  #   @event = Event.new(event_params)

  #   respond_to do |format|
  #     if @event.save
  #       format.html { redirect_to @event, notice: '展覧会情報の登録が完了しました' }
  #       format.json { render :show, status: :created, location: @event }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @event.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  # def update
  #   respond_to do |format|
  #     if @event.update(event_params)
  #       format.html { redirect_to @event, notice: 'Event was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @event }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @event.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    # @event.destroy
    # respond_to do |format|
    #   format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
    #   format.json { head :no_content }
  
    Event.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to events_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :from_date, :to_date, :from_time, :to_time, :prefecture, :price, :style, :link_url, :count_works, :discription, :style_id)
    end
    
    def event_search_params
    params.fetch(:search, {}).permit(:name, :from_date, :prefecture, :style_id)
    end
end
