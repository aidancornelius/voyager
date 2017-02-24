class MediaStoragesController < ApplicationController
  before_action :set_media_storage, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_administrator!, except: [:show]

  # GET /media_storages
  # GET /media_storages.json
  def index
    @media_storages = MediaStorage.all
  end

  # GET /media_storages/1
  # GET /media_storages/1.json
  def show
    redirect_to @media_storage.file.expiring_url(50)
  end

  # GET /media_storages/new
  def new
    @media_storage = MediaStorage.new
  end

  # GET /media_storages/1/edit
  def edit
  end

  # POST /media_storages
  # POST /media_storages.json
  def create
    @media_storage = MediaStorage.new(media_storage_params)

    respond_to do |format|
      if @media_storage.save
        format.html { redirect_to media_storages_path, notice: 'Media storage was successfully created.' }
        format.json { render :show, status: :created, location: @media_storage }
      else
        format.html { render :new }
        format.json { render json: @media_storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media_storages/1
  # PATCH/PUT /media_storages/1.json
  def update
    respond_to do |format|
      if @media_storage.update(media_storage_params)
        format.html { redirect_to media_storages_path, notice: 'Media storage was successfully updated.' }
        format.json { render :show, status: :ok, location: @media_storage }
      else
        format.html { render :edit }
        format.json { render json: @media_storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_storages/1
  # DELETE /media_storages/1.json
  def destroy
    @media_storage.destroy
    respond_to do |format|
      format.html { redirect_to media_storages_url, notice: 'Media storage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_storage
      @media_storage = MediaStorage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def media_storage_params
      params.require(:media_storage).permit(:title, :file)
    end
end
