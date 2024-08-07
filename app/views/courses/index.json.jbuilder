json.courses do

  puts @courses
  json.array! @courses do |course|
    json.partial! 'courses/course', course: course
  end
end
