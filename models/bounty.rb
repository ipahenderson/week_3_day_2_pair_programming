require('pg')
require('pp')

class Bounty

  attr_accessor :name, :bounty_value, :homeworld, :cashed_in
  attr_reader :id


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @homeworld = options['homeworld']
    @cashed_in = options['cashed_in']
  end


  def save
    db = PG.connect( {dbname:'bounties', host:'localhost'})
    sql = "INSERT INTO bounties
    (
      name,
      bounty_value,
      homeworld,
      cashed_in
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING *
    "
    values = [@name, @bounty_value, @homeworld, @cashed_in]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close
  end

  def self.all
      db = PG.connect( {dbname:'bounties', host:'localhost'})
      sql = "SELECT * FROM bounties"
      values = []
      db.prepare("all", sql)
      bounties_all = db.exec_prepared("all", values)
      db.close
      return bounties_all.map {|x| Bounty.new(x)}
  end

  def self.delete_all
      db = PG.connect( {dbname:'bounties', host:'localhost'})
      sql = "DELETE FROM bounties"
      values = []
      db.prepare("delete_all", sql)
      db.exec_prepared("delete_all", values)
      db.close
  end

  def delete
    db = PG.connect( {dbname:'bounties', host:'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close
  end



  def update
    db = PG.connect( {dbname:'bounties', host:'localhost'})
    sql = "UPDATE bounties
            SET
            (
            name,
            bounty_value,
            homeworld,
            cashed_in
            ) =
            ($1, $2, $3, $4)
            WHERE id = $5
          "
    values = [@name, @bounty_value, @homeworld, @cashed_in, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end


  def self.find(id)
    db = PG.connect( {dbname:'bounties', host:'localhost'})
    sql = " SELECT * FROM bounties WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    result = db.exec_prepared("find", values)
    db.close
    return result.map {|x| Bounty.new(x)}
  end

end
