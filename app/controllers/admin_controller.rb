class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_administrator!
  def index
  end
end
