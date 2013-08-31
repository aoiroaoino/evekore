require_relative "apidoorkeeper"
require_relative "apiatnd"
require_relative "apipartake"

class ApiAll

  def initialize
    doorkeeper = Apidoorkeeper.new
    atndJson = Apiatnd.new
    partake = Apipartake.new

    @viewJson = {"event" => []}
    @viewJson["event"].push(modifyDoorkeeperJson(doorkeeper.getJson)["event"])
    @viewJson["event"].push(modifyAtndJson(atndJson.getJson)["event"])
    @viewJson["event"].push(modifyPartakeJson(partake.getJson)["event"])

    @viewJson["event"].flatten!
  end

  def getResult
    @viewJson
  end

  def modifyDoorkeeperJson(doorkeeperJson)
    viewJson = {"event" => []}

    doorkeeperJson.each do |event|
      viewJsonEvent = {}
      viewJsonEvent["service"] = "DoorKeeper"
      viewJsonEvent["id"] = event["event"]["id"]
      viewJsonEvent["title"] = event["event"]["title"]
      viewJsonEvent["start_time"] = setDoorkeeperTime(event["event"]["starts_at"])
      viewJsonEvent["end_time"] = setDoorkeeperTime(event["event"]["ends_at"])
      viewJsonEvent["place"] = event["event"]["venue_name"]
      viewJsonEvent["address"] = event["event"]["address"]
      viewJsonEvent["personLimit"] = event["event"]["ticket_limit"]
      viewJsonEvent["personJoin"] = event["event"]["participants"]
      viewJsonEvent["personWait"] = event["event"]["waitlisted"]
      viewJsonEvent["Url"] = event["event"]["public_url"]

      viewJson["event"].push(viewJsonEvent)
    end

    viewJson
  end

  def setDoorkeeperTime(targetTime)
    if(targetTime != nil)
      hour = targetTime[12,2].to_i + 9
      if(hour > 24)
        hour - 24
      end

      targetTime[0,4] + '/' + targetTime[5,2] + '/' + targetTime[8,2] + ' ' + hour.to_s + targetTime[13,6]
    end
  end

  def modifyAtndJson(atndJson)
    viewJson = {"event" => []}

    atndJson["events"].each do |event|
      viewJsonEvent = {}
      viewJsonEvent["service"] = "ATND"
      viewJsonEvent["id"] = event["event_id"]
      viewJsonEvent["title"] = event["title"]
      viewJsonEvent["start_time"] = setDoorkeeperTime(event["started_at"])
      viewJsonEvent["end_time"] = setDoorkeeperTime(event["ended_at"])
      viewJsonEvent["place"] = event["place"]
      viewJsonEvent["address"] = event["address"]
      viewJsonEvent["personLimit"] = event["limit"]
      viewJsonEvent["personJoin"] = event["accepted"]
      viewJsonEvent["personWait"] = event["waiting"]
      viewJsonEvent["Url"] = event["event_url"]

      viewJson["event"].push(viewJsonEvent)
    end

    viewJson
  end

  def modifyPartakeJson(partakeJson)
    viewJson = {"event" => []}

    partakeJson["events"].each do |event|
      event["description"] = ''
      viewJsonEvent = {}
      viewJsonEvent["service"] = "Partake"
      viewJsonEvent["id"] = event["id"]
      viewJsonEvent["title"] = event["title"]
      viewJsonEvent["start_time"] = setPartakeTime(event["beginDate"])
      viewJsonEvent["end_time"] = setPartakeTime(event["endDate"])
      viewJsonEvent["place"] = event["place"]
      viewJsonEvent["address"] = event["address"]
      viewJsonEvent["personLimit"] = event["limit"]
      viewJsonEvent["personJoin"] = event["accepted"]
      viewJsonEvent["personWait"] = event["waiting"]
      viewJsonEvent["Url"] = 'http://partake.in/events/' + event["id"]

      viewJson["event"].push(viewJsonEvent)
    end

    viewJson
  end

  def setPartakeTime(targetTime)
    if(targetTime != nil)
      targetTime[0,4] + '/' + targetTime[5,2] + '/' + targetTime[8,2] + ' ' + targetTime[11,5] + ':00'
    end
  end
end

apiHelper = ApiAll.new
