require_relative 'call_api'

class Apidoorkeeper < CallApi

  def initialize
    super
    getJson
  end

  def getJson()
    jsonResult = super('api.doorkeeper.jp', '/events')
  end

end
