class LessonComponentsController < AdminController
  before_action :set_lesson_component, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_administrator!

  # GET /lesson_components
  # GET /lesson_components.json
  def index
    @lesson_components = LessonComponent.all.order(:lesson_id, :order)
  end

  # GET /lesson_components/1
  # GET /lesson_components/1.json
  def show
  end

  # GET /lesson_components/new
  def new
    @lesson_component = LessonComponent.new
  end

  # GET /lesson_components/1/edit
  def edit
  end

  # POST /lesson_components
  # POST /lesson_components.json
  def create
    @lesson_component = LessonComponent.new(lesson_component_params)

    respond_to do |format|
      if @lesson_component.save
        format.html { redirect_to @lesson_component, notice: 'Lesson component was successfully created.' }
        format.json { render :show, status: :created, location: @lesson_component }
      else
        format.html { render :new }
        format.json { render json: @lesson_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lesson_components/1
  # PATCH/PUT /lesson_components/1.json
  def update
    logger.info "--> Slug data received: #{@lesson_component.slug}"
    respond_to do |format|
      if @lesson_component.update(lesson_component_params)
        format.html { redirect_to @lesson_component, notice: 'Lesson component was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson_component }
      else
        format.html { render :edit }
        format.json { render json: @lesson_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lesson_components/1
  # DELETE /lesson_components/1.json
  def destroy
    @lesson_component.destroy
    respond_to do |format|
      format.html { redirect_to lesson_components_url, notice: 'Lesson component was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson_component
      slug = params[:id].split('_')
      @lesson_component = LessonComponent.where(lesson_id: slug.first, order: slug.last).last

      if !@lesson_component
        redirect_to root_url, notice: "That lesson has gone astray!"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_component_params
      params.require(:lesson_component).permit(:lesson_id, :style, :order, :title, :slug, :body, :feature)
    end
end
