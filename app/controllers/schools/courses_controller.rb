module Schools
  class CoursesController < SchoolsController
    layout 'course'

    before_action :load_course

    def show; end

    def update
      form = Schools::Courses::UpdateForm.new(@course)

      if form.validate(params[:course])
        form.save
        flash.now[:success] = 'Your profile has been updated.'
        redirect_back(fallback_location: school_course_path(@course))
      else
        render 'show'
      end
    end

    # POST /school/courses/:id/close
    def close
      ::Courses::CloseService.new(@course).close

      flash.now[:success] = "#{@course.name} closed successfully."
      redirect_back(fallback_location: school_course_path(@course))
    end

    private

    def load_course
      @course = authorize(courses.find(params[:id]), policy_class: Schools::CoursePolicy)
    end
  end
end
