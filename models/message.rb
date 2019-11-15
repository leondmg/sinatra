class Message
  DB_NAME = "items".freeze

  def initialize(params)
    @params = params
    return unless valid?
    conn.exec("INSERT INTO message(text) VALUES('#{@params[:text]}')")
  end

  def valid?
    @params[:text] != ""
  end

  def self.get(id)
    conn = PG.connect(dbname: DB_NAME)
    conn.exec("SELECT * FROM message WHERE id = #{id}").to_a[0]
  end

  def self.all
    conn = PG.connect( dbname: DB_NAME )
    conn.exec("SELECT * FROM message;").to_a
  end

  def self.delete(id)
    conn = PG.connect( dbname: DB_NAME )
    conn.exec("DELETE FROM message WHERE id = '#{id}';")
  end

  def self.getComments(id)
    conn = PG.connect( dbname: DB_NAME )
    conn.exec("SELECT * FROM comment WHERE id = '#{id}';").to_a
  end

  private

  def conn
    @conn ||= PG.connect( dbname: DB_NAME )
  end
end
