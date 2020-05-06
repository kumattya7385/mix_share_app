if Rails.env == 'development'
  User.create!(name:  "Example User",
    email: "example@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar",
    admin: true,
    activated: true
  )

  User.create!(name:  "ExampleKuma",
    email: "example1@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar",
    activated: true
  )

  (1..20).each do |i|
    Item.create(
      content: "テキスト#{i}",
      impressions_count: rand(100),
      title: "タイトル#{i}",
      user_id: rand(2)+1
    )
  end

  Item.create(
    content: "テキス",
    title: "タイトル",
    user_id: 1
  )

  Item.create(
    content: "テキスト4日前",
    title: "タイトル4日前",
    user_id: 2,
    created_at: Time.current.ago(4.days),
    updated_at: Time.current.ago(4.days),
    impressions_count: 99
  )

  Tag.create([
    {name: 'Ruby'},
    {name: 'Ruby on Rails5'},
    {name: 'Python3'},
    {name: 'Django'},
    {name: 'TDD'}
  ])
end