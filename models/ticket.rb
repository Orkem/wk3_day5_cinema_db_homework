require_relative('../db/sql_runner')
require_relative('screening')
require('pry')
class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id'] if options['film_id'] 
    @screening_id = options['screening_id']
  end

  def save
    #creates the screening object to return the asscociated film id

    screening_obj = screening()
    error = "Sorry this screening is sold out!"
    #raises an argument error if the screening is sold out.
    return error if screening_obj.fully_booked?

    sql = "INSERT INTO tickets
     (customer_id, film_id, screening_id) 
     VALUES
     (#{@customer_id}, #{@film_id}, #{@screening_id}) 
     RETURNING id;"
     @id = SqlRunner.run(sql)[0]['id'].to_i
     
  end

  def update
    sql = "UPDATE tickets SET
    (customer_id, film_id, screening_id) =
    ('#{@customer_id}', #{@film_id}, #{@screening_id})
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete
    SqlRunner.run("DELETE FROM tickets WHERE id = #{@id}")
  end

  def self.all
    sql = "SELECT * FROM tickets"
    return self.map_tickets(sql)
  end

  def self.delete_all
    SqlRunner.run("DELETE FROM tickets")
  end

  def screening
    #function updates the film id for the ticket using the screening object
    #This stops the need for giving ticket an extra parameter on init
    sql = "SELECT * FROM screenings
    WHERE id = #{@screening_id}"

    screening_obj = Screening.map_screenings(sql)[0]
    @film_id = screening_obj.film_id.to_i
    return screening_obj
  end

  def self.map_tickets(sql)
    tickets = SqlRunner.run(sql)
    return tickets.map{|ticket| Ticket.new(ticket)}
  end




















end