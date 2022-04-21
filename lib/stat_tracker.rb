require "pry"
require "csv"
require_relative "./game_teams"
require_relative "./games"
require_relative "./teams"
require_relative "./gmod"
require_relative "./gtmod"
require_relative "./tmod"
require_relative "./mixmod"

class StatTracker
  include GamesMod
  include GameTeamsMod
  include TeamsMod
  include MixMod
  attr_reader :teams, :game_teams, :games

  def initialize(stat_tracker)
    @games = Games.new(stat_tracker[:games])
    @teams = Teams.new(stat_tracker[:teams])
    @game_teams = GameTeams.new(stat_tracker[:game_teams])
  end

  def self.from_csv(locations)
    stats = {}
    locations.each do |file_key, location_value|
      csv = CSV.read(location_value, headers: true, header_converters: :symbol)
      stats[file_key] = csv.map { |row| row.to_h }
    end
    StatTracker.new(stats)
  end
end
