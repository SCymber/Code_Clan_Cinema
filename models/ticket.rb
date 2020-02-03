require_relative('../db/sql-runner.rb')
require_relative('film.rb')
require_relative('customer.rb')

class Ticket

attr_reader :id
attr_accessor :customer_id, :film_id

def initialize(options)
  @id = options['id'][0].to_i if options[@id]
  @customer_id = options['customer_id'].to_i
  @film_id = options['film_id'].to_i
end

def save()
  sql = "INSERT INTO tickets
  (
  customer_id,
  film_id
  )
  VALUES
  (
  $1, $2
  )
  RETURNING id"
  values = [@customer_id, @film_id]
  ticket = SqlRunner.run(sql, values).first
  @id = ticket['id'].to_i
end

def self.all()
  sql = "SELECT * FROM tickets"
  tickets = SQLRnner.run(sql)
  results = tickets.map{|ticket| Ticket.new(ticket)}
  return results
end

def update()
  sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
  values = [@customer_id, @film_id, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE * FROM tickets WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.map_items(data)
  result = data.map{|ticket| Ticket.new(ticket)}
  return result
end
  end
