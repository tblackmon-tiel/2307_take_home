# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Customer.create(first_name: "Kiwi", last_name: "Bird", email: "kiwibird@gmail.com", address: "1234 Bird Ave")
Customer.create(first_name: "Chicken", last_name: "Bird", email: "chicken@gmail.com", address: "01 Bird Cir")
Tea.create(title: "First Good Tea", description: "It's just a cool tea", temperature: 100, brew_time: 2)
Tea.create(title: "Second Good Tea", description: "It's just another sweet tea", temperature: 90, brew_time: 3)
Tea.create(title: "Third Good Tea", description: "It's just a third great tea", temperature: 101, brew_time: 5)