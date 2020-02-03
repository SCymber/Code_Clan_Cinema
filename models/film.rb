require_relative('../db/sql-runner.rb')
require_relative('ticket.rb')
require_relative('customer.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

def initialize(options)
  @title = options['title']
  @price = options['price']
  @id = options['id'][0].to_i if options['id']
end

def save()
  sql = "INSERT INTO films (
    title,
    price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * from films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE film_id = $1"
    values = [@id]
    customer = SqlRunner.run(sql, values)
    return customer.count
  end

  def self.map_items(data)
    result = data.map{|film| Film.new(film)}
    return result
  end
