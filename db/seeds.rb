if Rails.env == 'development'
  User.create!(name:  "Example User",
    email: "example@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar",
    admin: true,
    activated: true
  )
  Tag.create([
    {name: 'Ruby'},
    {name: 'Ruby on Rails5'},
    {name: 'Python3'},
    {name: 'Django'},
    {name: 'TDD'}
  ])
end