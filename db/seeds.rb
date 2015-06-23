# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(first_name: 'Corey', last_name: 'Soreff',
  email: 'xlive4honorx@gmail.com', encrypted_password: '$2a$10$Y3Gly82slIMyrFUtFdkVmOWvUtNlcOWUJ9ePnxIOIha0FMgG5Vd8y',
  device_token: 'ONEkbywfw1OY7P0G1NNV3Q-vmtVbi-4qZAj-FSHCi_A')