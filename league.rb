require 'httparty'
require 'pry-byebug'

class League
  include HTTParty
  base_uri "api.football-data.org"
  API_KEY = "7e00042747e94d65b6accef6c4613aa5"
  "X-Auth-Token"

  def self.headers
    { "X-Auth-Token" => API_KEY }
  end

  def self.all
    response = get("/v1/soccerseasons", headers: headers)
    seasons_json = JSON.parse(response.body)
    leagues = []
    seasons_json.each do |season|
      league_name = season["caption"]

      league_uri = URI.parse(season["_links"]["self"]["href"])
      league_id = league_uri.path.split("/").last

      leagues << League.new(
        league_name: league_name,
        league_id: league_id
      )
    end
    return leagues
  end

  def self.find

  end

  attr_reader :league_name, :league_id

  def initialize(attributes = {})
    @league_name = attributes[:league_name]
    @league_id = attributes[:league_id]
  end
end
