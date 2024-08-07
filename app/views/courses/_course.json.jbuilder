json.extract! course, :id, :name, :description, :created_at, :updated_at
json.tutors do
  json.array! course.tutors do |tutor|
    json.extract! tutor, :id, :name
  end
end
