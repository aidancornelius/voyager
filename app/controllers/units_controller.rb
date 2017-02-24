class UnitsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :purchase_first!, except: [:index]
  before_action :find_component, only: [:lesson_component]
  def index
    @lessons = Lesson.where(visible: true).order(:unlock)
  end

  def lesson_component
    @reply = Reply.new
    render template: @style
  end

  private
  def find_lesson
    @lesson = Lesson.find_by_slug(params[:module_slug])
  end

  def find_component
    find_lesson

    @component = @lesson.lesson_components.find_by_order(params[:component_slug])

    if !@component
      @component = @lesson.lesson_components.find_by_slug(params[:component_slug])
    else
      redirect_to "/modules/#{@lesson.slug}/#{@component.slug}"
    end

    if !@component.present?
      @module ||= Lesson.find_by_slug(params[:module_slug])
      if @module.present?
        redirect_to "#{units_path}/#mj_#{@module.id}"
      else
        redirect_to units_path
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
