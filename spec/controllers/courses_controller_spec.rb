require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  render_views

  describe 'test index action' do
    let!(:course_one) { create(:course, :one) }
    let!(:course_two) { create(:course, :two) }

    let!(:tutor_hyung) { create(:tutor, :hyung, course: course_one) }
    let!(:tutor_rachel) { create(:tutor, :rachel, course: course_one) }
    let!(:tutor_john) { create(:tutor, :john, course: course_two) }

    it 'returns a success response for html' do
      get :index, format: :html
      expect(assigns(:courses)).to include(course_one, course_two)
    end

    it 'returns a success response for json' do
      response = get :index, format: :json
      json_response = JSON.parse(response.body)
      expect(json_response['courses']).to include(
        a_hash_including(
          'id' => course_one.id,
          'name' => 'Computer Science',
          'description' => 'This is the CS course.',
          'tutors' => [
            a_hash_including('id' => tutor_hyung.id, 'name' => 'Hyung Me'),
            a_hash_including('id' => tutor_rachel.id, 'name' => 'Rachel Williams')
          ]
        ),
        a_hash_including(
          'id' => course_two.id,
          'name' => 'Data Science',
          'description' => 'This is the DS course.',
          'tutors' => [a_hash_including('id' => tutor_john.id, 'name' => 'John Frost')]
        )
      )
    end
  end

  describe 'test create action' do
    let(:valid_attributes) { { name: 'Course 1', description: 'new course created!' } }
    let(:invalid_attributes) { { name: '', description: 'This course has no name.' } }

    it 'creates Course 1' do
      expect do
        post :create, params: { course: valid_attributes }, format: :html
      end.to change(Course, :count).by(1)
    end

    it 'redirects to the courses index' do
      post :create, params: { course: valid_attributes }, format: :html
      expect(response).to redirect_to(courses_path)
      expect(flash[:notice]).to eq('Course and its tutors were successfully created.')
    end

    it 'returns a JSON response with the newly created course' do
      post :create, params: { course: valid_attributes }, format: :json
      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body)

      expect(json_response['courses'].first['name']).to eq('Course 1')
      expect(json_response['courses'].first['description']).to eq('new course created!')
    end

    it 'does not create invalid Course' do
      expect do
        post :create, params: { course: invalid_attributes }, format: :html
      end.not_to change(Course, :count)
    end

    it 'renders the new template' do
      post :create, params: { course: invalid_attributes }, format: :html
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns a JSON response with errors for the new course' do
      post :create, params: { course: invalid_attributes }, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response).to include('name')
    end
  end
end
