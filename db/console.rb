require_relative('../models/customer')
require_relative('../models/ticket')
require_relative('../models/film')
require_relative('../models/screening')
require('pry')

Ticket.delete_all
Screening.delete_all
Customer.delete_all
Film.delete_all

customer_chris = Customer.new({"name" => "Chris", "funds" => 100})
customer_chris.save

customer2 = Customer.new({"name" => "Rick", "funds" => 50})
customer2.save

customer3 = Customer.new({"name" => "Hobs", "funds" => 40})
customer3.save


raiders = Film.new({"title" => "Raiders of the lost ark", "price" => 13})
raiders.save
film2 = Film.new({"title" => "Robocop", "price" => 12})
film2.save


screening1 = Screening.new({"screening" => "18:00", "film_id" => raiders.id})
screening2 = Screening.new({"screening" => "21:00", "film_id" => raiders.id})
screening3 = Screening.new({"screening" => "21:00", "film_id" => film2.id})
screening1.save
screening2.save
screening3.save

# screening1.screening = "19:00"
# screening1.update


c_ticket_raiders = Ticket.new({"customer_id" =>customer_chris.id, "screening_id" => screening1.id})
c_ticket_raiders.save

ticket2 = Ticket.new({"customer_id" =>customer2.id, "screening_id" => screening2.id})
ticket2.save

ticket3 = Ticket.new({"customer_id" =>customer3.id, "screening_id" => screening2.id})
ticket3.save
ticket4 = Ticket.new({"customer_id" =>customer3.id, "screening_id" => screening3.id})
ticket4.save

# ticket2.customer_id = customer_chris.id
# ticket2.update

# customer2.name = "John"
# customer2.update

# film2.title = "Lion King"
# film2.update

# customer2.show_films
# film2.show_customers
# ticket5 = Ticket.new({"customer_id" =>customer3.id, "screening_id" => screening2.id})
# ticket5.save
Ticket.popular_film
raiders.popular_screen
binding.pry
nil