class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]
  before_action :require_administrator!, except: [:create, :destroy, :star]
  before_action :authenticate_user!

  # GET /replies
  # GET /replies.json
  def index
    @replies = Reply.all
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
  end

  # GET /replies/new
  def new
    @reply = Reply.new
  end

  def star
    @reply = Reply.find_by_id(params[:reply_id])
    if @reply.stars.present? && @reply.stars >= 1
      @stars = @reply.stars + 1
    else
      @stars = 1
    end
    @reply.update( stars: @stars )
    redirect_to "/modules/#{@reply.lesson_component.lesson.slug}/#{@reply.lesson_component.order}#comment-#{@reply.id}", notice: "Comment starred"
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = Reply.new(reply_params)

    @reply.user_id = current_user.id

    respond_to do |format|
      if @reply.save
        format.html {
          if @reply.reply.present? && @reply.reply.user_id.present?
            message_user(@reply.reply.user_id, "New reply to your comment #{@reply.lesson_component.title}", "#{current_user.firstname} replied to your comment on #{@reply.lesson_component.title} at #{@reply.created_at.strftime("%B %-d, %Y at %-l:%M %P")}", "/modules/#{@reply.lesson_component.lesson.slug}/#{@reply.lesson_component.order}#comment-#{@reply.id}")
          end
          redirect_to "/modules/#{@reply.lesson_component.lesson.slug}/#{@reply.lesson_component.order}#comment-#{@reply.id}", notice: "Comment added"
         }
        format.json { render :show, status: :created, location: @reply }
      else
        format.html {
          redirect_to "/modules/#{@reply.lesson_component.lesson.slug}/#{@reply.lesson_component.order}#comment-panel", notice: @reply.errors
        }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replies/1
  # PATCH/PUT /replies/1.json
  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { render :edit }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply.destroy
    respond_to do |format|
      format.html {
          redirect_to "/modules/#{@reply.lesson_component.lesson.slug}/#{@reply.lesson_component.order}#comment-panel", notice: "Comment was successfully destroyed"
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:lesson_component_id, :user_id, :reply_id, :body)
    end
end
