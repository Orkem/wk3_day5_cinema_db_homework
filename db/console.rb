require_relative('../models/customer')
require_relative('../models/ticket')
require_relative('../models/film')
require('pry')

customer_chris = Customer.new({"name" => "Chris", "funds" => 100})

customer_chris.save

raiders = Film.new({"title" => "Raiders of the lost ark", "price" => 13})

raiders.save

binding.pry
nil