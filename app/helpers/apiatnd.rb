require_relative 'call_api'

class Apiatnd < CallApi

  def initialize
    super
    getJson()
  end

  def getJson()
    jsonResult = super('api.atnd.org', '/events?format=json')
  end

end
