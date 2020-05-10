class EventimagesController < ApplicationController
  before_action :set_eventimage, only: [:show, :edit, :update, :destroy]

  # GET /eventimages
  # GET /eventimages.json
  def index
    @eventimages = Eventimage.all
  end

  # GET /eventimages/1
  # GET /eventimages/1.json
  def show
  end

  # GET /eventimages/new
  def new
    @eventimage = Eventimage.new
  end

  # GET /eventimages/1/edit
  def edit
  end

  # POST /eventimages
  # POST /eventimages.json
  def create
    @eventimage = Eventimage.new(eventimage_params)

    respond_to do |format|
      if @eventimage.save
        format.html { redirect_to @eventimage, notice: 'Eventimage was successfully created.' }
        format.json { render :show, status: :created, location: @eventimage }
      else
        format.html { render :new }
        format.json { render json: @eventimage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eventimages/1
  # PATCH/PUT /eventimages/1.json
  def update
    respond_to do |format|
      if @eventimage.update(eventimage_params)
        format.html { redirect_to @eventimage, notice: 'Eventimage was successfully updated.' }
        format.json { render :show, status: :ok, location: @eventimage }
      else
        format.html { render :edit }
        format.json { render json: @eventimage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eventimages/1
  # DELETE /eventimages/1.json
  def destroy
    @eventimage.destroy
    respond_to do |format|
      format.html { redirect_to eventimages_url, notice: 'Eventimage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eventimage
      @eventimage = Eventimage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def eventimage_params
      params.require(:eventimage).permit(:image, :name)
    end
end
