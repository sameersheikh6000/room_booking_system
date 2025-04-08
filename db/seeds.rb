# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(email: "Admin@example.com", password: "Admin@123", password_confirmation: "Admin@123", role: :admin)
Room.create!(name: "Room A", capacity: 5, price_per_hour: 25, active: true)
Room.create!(name: "Room B", capacity: 10, price_per_hour: 40, active: true)