Employee.create!(name: "Example Manager", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar", admin: true, activated: true, activated_at: Time.zone.now)
Employee.create(name: "Second Example Employee", email: "example@manager.com", password: "foobar", password_confirmation: "foobar", admin: true, activated: true, activated_at: Time.zone.now)
50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "foobar"
  Employee.create!(name: name, email: email, password: password, password_confirmation: password, manager_id: 1, activated: true, activated_at: Time.zone.now )
end
20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+50+1}@railstutorial.org"
  password = "foobar"
  Employee.create!(name: name, email: email, password: password, password_confirmation: password, manager_id: 2, activated: true, activated_at: Time.zone.now )
end
Manager.create!(name: "Example Manager", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar", admin: true)
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "foobar"
  Manager.create!(name: name, email: email, password: password, password_confirmation: password)
end