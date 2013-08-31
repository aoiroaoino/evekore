require 'json'
require_relative '../models/mongodb'

class MongoApi
  mongodb = Mongodb.new

  mongodb.get_collection_all
end