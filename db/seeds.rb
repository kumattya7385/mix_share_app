User.create!(name:  "Example User",
  email: "example@vmish.com",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true,
  activated: true,
  content: "こんにちは。これはユーザープロフィール用のテストです。表示が上手くいっているといいです。"
)

User.create!(name:  "TestUser",
  email: "TestUser@vmish.com",
  password:              "foobar",
  password_confirmation: "foobar",
  activated: true
)

(1..20).each do |i|
  Item.create(
    content: "テストテキスト#{i}",
    impressions_count: rand(100),
    title: "テストタイトル#{i}",
    user_id: rand(2)+1
  )
end