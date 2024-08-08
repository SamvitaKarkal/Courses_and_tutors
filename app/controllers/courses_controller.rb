class CoursesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create index]
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @courses = Course.includes(:tutors).all

    respond_to do |format|
      format.html
      format.json { render :index }
    end
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
    @course.tutors.build
  end

  # GET /courses/1/edit
  def edit; end

  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        @courses = Course.includes(:tutors).all

        format.html { redirect_to courses_path, notice: 'Course and its tutors were successfully created.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy!

    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, tutors_attributes: %i[id name _destroy])
  end
end
