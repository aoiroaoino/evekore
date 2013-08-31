require_relative "apidoorkeeper"
require_relative "apiatnd"
require_relative "apiparkate"

class ApiAll

  def initialize
    doorkeeper = Apidoorkeeper.new
    atndJson = Apiatnd.new
    parkateJson = Apiparkate.new

    viewJson = {"event" => []}
    #viewJson["event"].push(modifyDoorkeeperJson(doorkeeper.getJson)["event"])
    #viewJson["event"].push(modifyAtndJson(atndJson.getJson)["event"])
    #viewJson["event"].push(modifyParkateJson(parkateJson.getJson)["event"])

    viewJson
  end

  def modifyDoorkeeperJson(doorkeeperJson)
    viewJson = {"event" => []}

    doorkeeperJson.each do |event|
      viewJsonEvent = {}
      viewJsonEvent["service"] = "DoorKeeper"
      viewJsonEvent["id"] = event["event"]["id"]
      viewJsonEvent["title"] = event["event"]["title"]
      viewJsonEvent["start_time"] = event["event"]["starts_at"]
      viewJsonEvent["end_time"] = event["event"]["ends_at"]
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

  def modifyAtndJson(atndJson)
    viewJson = {"event" => []}

    atndJson["events"].each do |event|
      viewJsonEvent = {}
      viewJsonEvent["service"] = "ATND"
      viewJsonEvent["id"] = event["event_id"]
      viewJsonEvent["title"] = event["title"]
      viewJsonEvent["start_time"] = event["started_at"]
      viewJsonEvent["end_time"] = event["ended_at"]
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



  def modifyParkateJson(parkateJson)
    viewJson = {"event" => []}

    parkateJson["events"].each do |event|
      event["description"] = ''
      viewJsonEvent = {}
      viewJsonEvent["service"] = "Parkate"
      viewJsonEvent["id"] = event["id"]
      viewJsonEvent["title"] = event["title"]
      viewJsonEvent["start_time"] = event["beginDate"]
      viewJsonEvent["end_time"] = event["endDate"]
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
end

apiHelper = ApiAll.new
