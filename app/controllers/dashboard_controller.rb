class DashboardController < ApplicationController
  before_action :authenticate_user!
  #before_action :purchase_first!

  def index
    @lessons = Lesson.where(visible: true).order(:unlock)

    @lessons.each do |lesson|
      if (current_user.created_at + lesson.unlock.weeks).past?
        @latestLesson = lesson
      end
    end

  end
end
