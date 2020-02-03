require_relative("..db/sql_runner")
require_relative("films.rb")
require_relative("tickets.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i()
    @id = options['id'].to_i() if options ['id']
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first()
    @id = customer['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    results = customers.map{|customer| Customer.new(customer)}
    return results
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
end

  def update()
    sql = "
    UPDATE customer SET (
      name,
      funds
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

def delete()
  sql = "DELETE * FROM customers WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON films.id  = tickets.film_id
    WHERE customer_id = $1"
    values = [@id]
    film = SqlRunner.run(sql, values)
    return FILM.map_items(film)
  end
