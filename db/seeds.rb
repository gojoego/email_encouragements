if defined?(Encouragement)
  Encouragement.find_or_create_by!(slug: "you're okay") do |e|
    e.subject = "you're going to be okay!"
    e.body    = "take a deep breathe and remember that uncomfortable feelings are fleeting and don't last forever"
    e.interval_minutes = 1440  # example attribute if you schedule by interval
  end

  Encouragement.find_or_create_by!(slug: "you got this") do |e|
    e.subject = "you got this!"
    e.body    = "remember, progress takes time -> favor progress over perfection"
    e.interval_minutes = 1440
  end
end

if defined?(Subscriber)
  Subscriber.find_or_create_by!(email: "test@example.com") do |s|
    s.name = "Test User"
  end
end

puts "Seeded! Encouragements: #{Encouragement.count if defined?(Encouragement)}"

