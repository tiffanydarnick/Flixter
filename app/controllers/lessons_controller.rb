class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_course_enrollment_for_lesson, :only => :show
	
	def show
	end

	private

	def require_course_enrollment_for_lesson
		active_course = current_lesson.section.course
		 if current_lesson.section.course.user.enrolled_in?(active_course) 
		 	redirect_to course_path(active_course), alert: 'Please enroll to access lesson'
		 end
    end

	helper_method :current_lesson
	def current_lesson
		@current_lesson ||= Lesson.find(params[:id])
	end 
end
