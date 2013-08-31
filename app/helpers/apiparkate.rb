require_relative 'call_api'

class Apiparkate < CallApi

  def initialize
    super
    getJson
  end

  def getJson()
    jsonResult = super('partake.in', '/api/event/search')
  end

end

apidoorKeeper = Apidoorkeeper.new
