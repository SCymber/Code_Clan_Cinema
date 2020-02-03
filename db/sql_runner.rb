require('pg')

class SqlRunner

  def self.run( sql, values = [] )
    begin
      db = PG.conect({ dbname: 'code_clan_cinema', host: 'localhost'})
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure
      db.close() if db != nil
    end
    return result
  end
end
