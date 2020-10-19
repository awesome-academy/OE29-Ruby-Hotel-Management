# User.create!(name: "Bùi Hữu Hoàng",
#              username: "bhhoang",
#              age: 22,
#              address: "Ha Noi",
#              email: "bhhoang1998@gmail.com",
#              password: "1111111111",
#              password_confirmation: "1111111111",
#              role: 2,
#              activated: true,
#              activated_at: Time.zone.now)
#
# 50.times do |n|
#   name = Faker::Name.name
#   username = Faker::FunnyName.name
#   email = "example-#{n+1}@gmail.com"
#   password = "1111111111"
#   age= 20
#   address = "Ha Noi"
#   role = [0, 1, 2].sample
#
#   User.create!(name: name,
#                username: username,
#                age: age,
#                address: address,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                role: role,
#                gender: 1,
#                activated: true,
#                activated_at: Time.zone.now)
# end
#
# views = ["Sea View", "Garden View", "Planet View", "Lake View", "Mountains View"]
# views.each do |view|
#   View.create!(
#       name: view
#   )
# end
#
# types = %w[Double Triple]
# types.each do |type|
#   Type.create!(
#       name: type
#   )
# end
# unities = %w[PC Time]
# unities.each do |unity|
#   Unity.create!(
#     name: unity
#   )
# end
#
# 20.times do
#   name = Faker::Food.dish
#   unity_id = [1, 2].sample
#   des = Faker::Lorem.paragraph_by_chars(number: 400)
#
#   Service.create!(name: name,
#                   price: 100000,
#                   des: des,
#                   unity_id: unity_id)
# end
