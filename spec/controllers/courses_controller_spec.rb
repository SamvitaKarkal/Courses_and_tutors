require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let!(:course_one) { create(:course, :one) }
  let!(:course_two) { create(:course, :two) }

  let!(:tutor_hyung) { create(:tutor, :hyung, course: course_one) }
  let!(:tutor_rachel) { create(:tutor, :rachel, course: course_one) }
  let!(:tutor_john) { create(:tutor, :john, course: course_two) }

  describe 'with JSON format' do
    it 'returns a success response with courses and their tutors' do
      get :index, format: :json
      puts "Response body: #{response.body}"
      
      expect(response).to be_successful
      json_response = JSON.parse(response.body)

      expect(json_response['courses'].size).to eq(2)

      expect(json_response['courses']).to include(
        a_hash_including(
          "id" => course_one.id,
          "name" => "Computer Science",
          "description" => "This is the CS course.",
          "tutors" => [
            a_hash_including("id" => tutor_hyung.id, "name" => "Hyung Me"),
            a_hash_including("id" => tutor_rachel.id, "name" => "Rachel Williams")
          ]
        ),
        a_hash_including(
          "id" => course_two.id,
          "name" => "Data Science",
          "description" => "This is the DS course.",
          "tutors" => [
            a_hash_including("id" => tutor_john.id, "name" => "John Frost")
          ]
        )
      )
    end
  end
end
