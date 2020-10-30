User.create!(name: "Bùi Hữu Hoàng",
             username: "bhhoang",
             age: 22,
             address: "Ha Noi",
             email: "bhhoang1998@gmail.com",
             password: "1111111111",
             password_confirmation: "1111111111",
             role: 2,
             activated: true,
             activated_at: Time.zone.now)

5.times do |n|
  name = Faker::Name.name
  username = Faker::FunnyName.name
  email = "example-#{n+1111}@gmail.com"
  password = "1111111111"
  age= 20
  address = "Ha Noi"
  role = 1

  User.create!(name: name,
               username: username,
               age: age,
               address: address,
               email: email,
               password: password,
               password_confirmation: password,
               role: role,
               gender: 1,
               activated: true,
               activated_at: Time.zone.now)
end

50.times do |n|
  name = Faker::Name.name
  username = Faker::FunnyName.name
  email = "example-#{n+1}@yahoo.com"
  password = "1111111111"
  age= 20
  address = "Ha Noi"
  role = 0
  created_at = Date.today + (2..30).to_a.sample

  User.create!(name: name,
               username: username,
               age: age,
               address: address,
               email: email,
               password: password,
               password_confirmation: password,
               role: role,
               gender: 1,
               activated: true,
               created_at: created_at,
               activated_at: Time.zone.now)
end

views = ["Sea View", "Garden View", "Planet View", "Lake View", "Mountains View"]
views.each do |view|
  View.create!(
      name: view
  )
end

types = %w[Double Triple]
types.each do |type|
  Type.create!(
      name: type
  )
end
unities = %w[PC Time]
unities.each do |unity|
  Unity.create!(
      name: unity
  )
end

20.times do
  name = Faker::Food.dish
  unity_id = [1, 2].sample
  des = Faker::Lorem.paragraph_by_chars(number: 400)

  Service.create!(name: name,
                  price: 100000,
                  des: des,
                  unity_id: unity_id)
end

20.times do
  name = Faker::Food.dish
  price = [100000, 200000, 300000, 400000].sample
  view_id = [1, 2 ,3 ,4 ,5].sample
  type_id = [1, 2].sample
  des = Faker::Lorem.paragraph_by_chars(number: 350)

  Room.create!(name: name,
               price: price,
               view_id: view_id,
               type_id: type_id,
               des: des)
end

20.times do |n|
  room_id = n + 1

  Picture.create!(room_id: room_id,
                  remote_picture_url: "https://cf.bstatic.com/images/hotel/max1024x768/109/109697480.jpg")
end

10.times do |n|
  user_id = n + 7 + 26

  10.times do
    status = [0, 1, 2 ,3].sample
    price = [500000, 600000, 700000, 800000].sample
    create_at = Date.today - (1..60).to_a.sample

    Bill.create!(status: status,
                 price: price,
                 user_id: user_id,
                 created_at: create_at)
  end
end
