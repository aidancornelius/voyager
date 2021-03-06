class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :check_ownership
  before_action :authenticate_user!

  # GET /messages
  # GET /messages.json
  def index
    @messages ||= Message.where(user_id: current_user.id).order(created_at: :desc)
    if current_user.administrator? && params[:all] == "true"
      @messages = Message.all.order(created_at: :desc)
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message.read = true
    @message.save
    redirect_to messages_path
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.from_user_id = current_user.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_path, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to messages_path, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def check_ownership
      if @message.present?
        if @message.user_id == current_user.id
          # Permitted
        elsif current_user.administrator?
          # Permitted
        else
          redirect_to messages_path, notice: "That message doesn't belong to you."
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:user_id, :from_user_id, :from_thread_id, :title, :body, :link, :read)
    end
end
