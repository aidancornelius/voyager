class UnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_component, only: [:lesson_component]
  def index
    find_course
    @lessons = Lesson.where(visible: true, course: @course).order(:unlock)
  end

  def lesson_component
    @reply = Reply.new
    render template: @style
  end

  private

  def find_course
    @course = Course.find_by_slug(params[:course_slug])
    if !@course.present?
      redirect_to "/not_found"
    end
  end

  def find_lesson
    find_course
    @lesson = Lesson.find_by_slug(params[:module_slug])
  end

  def find_component
    find_lesson

    @component = @lesson.lesson_components.find_by_order(params[:component_slug])

    if !@component
      @component = @lesson.lesson_components.find_by_slug(params[:component_slug])
    else
      redirect_to "/course/#{@course.slug}/modules/#{@lesson.slug}/#{@component.slug}"
    end

    if !@component.present?
      @module ||= Lesson.find_by_slug(params[:module_slug])
      if @module.present?
        redirect_to "/course/#{@course.slug}/modules/#mj_#{@module.id}"
      else
        redirect_to "/course/#{@course.slug}/modules/"
      end
    else
      @style = find_style(@component.style)
    end
  end

  def find_style(style)
    # {"Multimodal [+c]" => "1", "Multimodal [-c]" => "2", "Video [+c]" => "3", "Video [-c]" => "4", "Discussion [+c]" => "5"}
    # Please update these in form in lesson_components/_form

    case style
      when 1
        @discussion = true
        "units/multimodal.html.erb"
      when 2
        @discussion = false
        "units/multimodal.html.erb"
      when 3
        @discussion = true
        "units/video.html.erb"
      when 4
        @discussion = false
        "units/video.html.erb"
      when 5
        @discussion = true
        "units/discussion.html.erb"
    end
  end
end
