require 'json'
require_relative '../models/mongodb'

class MongoApi

  def initialize
    mongodb = Mongodb.new

    @viewJson = mongodb.get_collection_all
  end

  def getResult
    @viewJson
  end
end