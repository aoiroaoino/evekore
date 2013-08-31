class Mongodb
  require 'mongo'
  require 'uri'
  require 'json'

  #if Rails.env == 'development'
  #  MONGOHQ_URL = 'mongodb://evekore:1234@localhost:27017/evekore'
  #elsif Rails.env == 'production'
    MONGOHQ_URL = 'mongodb://evekore:1234@paulo.mongohq.com:10048/evekore'
  #end

  def initialize
    connection = get_connection
    @evekore_collection = connection.collection("evekore")
  end

  def get_connection
    return @db_connection if @db_connection
    db = URI.parse(MONGOHQ_URL)
    db_name = db.path.gsub(/^\//, '')
    @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
    @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
    @db_connection
  end

  def get_collection_all
    @evekore_collection.find.to_a
  end

  def update_mongodb(rawdata)
    @evekore_collection.update({"_id" => ""}, rawdata, {:upsert => true})
  end
end