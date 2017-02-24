class CompletionsController < ApplicationController
  before_action :set_completion, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :purchase_first!

  # POST /completions
  def create
    @completion = Completion.new

    @completion.user_id = current_user.id
    @completion.lesson_component_id = params[:lesson_component_id]

    if @completion.save
      redirect_to "/modules/#{@completion.lesson_component.lesson.slug}/#{@completion.lesson_component.order}", notice: "Yes! Lesson completed. Congratulations on finishing, move on to the next lesson below."
    else
      redirect_to "/modules", notice: "Hmm, looks like you've already completed that lesson!"
    end
  end

  # DELETE /completions/1
  def destroy
    if @completion.destroy
      redirect_to "/modules/#{@completion.lesson_component.lesson.slug}/#{@completion.lesson_component.order}", notice: "Starting fresh? That's cool. This lesson is no longer marked as complete."
    else
      redirect_to "/modules", notice: "Hmm, looks like you've already completed that lesson!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_completion
      @completion = Completion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def completion_params
      params.require(:completion).permit(:user_id, :lesson_component_id)
    end
end
