class EvekoreController < ApplicationController
  require 'apiAll'
  require 'mongo_api'

  def index
  	# api = ApiAll.new
  	api = MongoApi.new
  	@events = api.getResult.first["event"].sort{|f,s| f["start_time"].split("\s")[0] <=> s["start_time"].split("\s")[0]
  	  }.sort{|f,s| f["start_time"].split("\s")[1] <=> s["start_time"].split("\s")[1]}
  end

  def time_sort
  	@events.sort{|f,s| f.first <=> s.first}.sort{|f,s| f[1] <=> s[1]} unless str.nil?
  end

end