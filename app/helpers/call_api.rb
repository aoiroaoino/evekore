require 'net/http'
require 'json'

class CallApi

  def initialize
  end

  def getJson(targetHeadUrl, targetBodyUrl)
    httpsend = Net::HTTP.new(targetHeadUrl,80)

    requestResult = Net::HTTP::Get.new(targetBodyUrl)
    httpResult = httpsend.request(requestResult)

    JSON.parse(httpResult.body)
  end
end