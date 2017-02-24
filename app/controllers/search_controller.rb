class SearchController < ApplicationController
  before_action :authenticate_user!

  def tags
    @lessons = Lesson.tagged_with(params[:q]).where(visible: true)
  end
end
