class Comment
  DB_NAME = "items".freeze

  def initialize(params)
    @params = params
    return unless valid?
    conn.exec("INSERT INTO comment(text, id_mes) VALUES('#{@params[:text]}', #{@params[:ms]})")
  end

  def valid?
    @params[:text] != ""
  end

  def self.all
    conn = PG.connect( dbname: DB_NAME )
    conn.exec("SELECT * FROM comment;").to_a
  end
  
  def self.get_all_like(mes_id)
    conn = PG.connect( dbname: DB_NAME )
    conn.exec("SELECT * FROM comment where id_mes = #{mes_id}").to_a
  end

  def self.delete(id)
    conn = PG.connect( dbname: DB_NAME )
    conn.exec("DELETE FROM comment WHERE id = #{id};")
  end

  private

  def conn
    @conn ||= PG.connect( dbname: DB_NAME )
  end
end
