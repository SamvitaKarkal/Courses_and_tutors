json.courses do
  json.array! @courses do |course|
    json.partial! 'courses/course', course: course
  end
end
