require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry-byebug')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

film1 = Film.new({
  'title' => 'Superman'
  'price' => 3
  })
film1.save()

film2 = Film.new({
  'title' => 'Spiderman'
  'price' => 5
  })
film2.save()

film3 = Film.new({
  'title' => 'Shrek'
  'price' => 10
})
film3.save()

customer1 = Customer.new({
  'name' => 'Jimmy'
  'funds' => 50
  })
customer1.save()

customer2 = Customer.new({
  'name' => 'Tam'
  'funds' => 50
  })
customer2.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })
ticket1.save()

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
  })
ticket2.save()

ticket3 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2
  })
  ticket3.save()

  binding.pry
nil
