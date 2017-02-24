class LandingsController < ApplicationController
  before_action :set_landing, only: [:show, :edit, :update, :destroy]
  before_action :require_administrator!

  # GET /landings
  # GET /landings.json
  def index
    @landings = Landing.all
  end

  # GET /landings/1
  # GET /landings/1.json
  def show
    gibbon = Gibbon::Request.new
    @mc_list = gibbon.lists(@landing.mailchimp_list).retrieve
  end

  # GET /landings/new
  def new
    gibbon = Gibbon::Request.new
    @mc_lists = gibbon.lists.retrieve
    @landing = Landing.new
  end

  # GET /landings/1/edit
  def edit
    gibbon = Gibbon::Request.new
    @mc_lists = gibbon.lists.retrieve
  end

  # POST /landings
  # POST /landings.json
  def create
    @landing = Landing.new(landing_params)

    respond_to do |format|
      if @landing.save
        format.html { redirect_to @landing, notice: 'Landing was successfully created.' }
        format.json { render :show, status: :created, location: @landing }
      else
        format.html { render :new }
        format.json { render json: @landing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /landings/1
  # PATCH/PUT /landings/1.json
  def update
    respond_to do |format|
      if @landing.update(landing_params)
        format.html { redirect_to @landing, notice: 'Landing was successfully updated.' }
        format.json { render :show, status: :ok, location: @landing }
      else
        format.html { render :edit }
        format.json { render json: @landing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /landings/1
  # DELETE /landings/1.json
  def destroy
    @landing.destroy
    respond_to do |format|
      format.html { redirect_to landings_url, notice: 'Landing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_landing
      @landing = Landing.find(params[:id])
      gibbon = Gibbon::Request.new
      @mc_lists = gibbon.lists.retrieve
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def landing_params
      params.require(:landing).permit(:title, :slug_before, :slug_after, :body_before, :body_after, :mailchimp_list, :download)
    end
end
