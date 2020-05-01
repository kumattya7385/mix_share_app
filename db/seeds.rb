if Rails.env == 'development'
  (1..100).each do |i|
      Item.create(name: "ユーザ#{i}", title: "タイトル#{i}", content: "本文#{i}")
  end

  Tag.create([
    {name: 'Ruby'},
    {name: 'Ruby on Rails5'},
    {name: 'Python3'},
    {name: 'Django'},
    {name: 'TDD'}
  ])
end