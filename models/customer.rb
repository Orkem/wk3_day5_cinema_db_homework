require_relative('../db/sql_runner')
require_relative('film')
require_relative('ticket')
class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end
  
  def buy_ticket(film_obj)
    #create ticket
    Ticket.new(
      {'customer_id' => @id,
        'film_id' => film_obj.id
      })
    #remove film price from funds
    @funds -= film_obj.price
    #update customer in db
    update()
  end

  def how_many_tickets
    #count is postgres' built in function returns hash with 'count' => 'number' 
    sql = "SELECT count(*) FROM tickets 
        WHERE customer_id = #{@id};"
    return SqlRunner.run(sql)[0]['count'].to_i
  end

  def show_films
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON films.id = film_id
    WHERE
    customer_id = #{@id};"
    return Film.map_films(sql)
  end


  def save
    sql = "INSERT INTO customers
     (name, funds) 
     VALUES
     ('#{@name}', #{@funds}) 
     RETURNING id;"
     @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def update
    sql = "UPDATE customers SET
    (name, funds) =
    ('#{@name}', #{@funds})
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end


  def delete
    SqlRunner.run("DELETE FROM customers WHERE id = #{@id}")
  end

  def self.all
    sql = "SELECT * FROM customers"
    return self.map_customers(sql)
  end

  def self.delete_all
    SqlRunner.run("DELETE FROM customers")
  end

  def self.map_customers(sql)
    customers = SqlRunner.run(sql)
    return customers.map{|customer| Customer.new(customer)}
  end














end