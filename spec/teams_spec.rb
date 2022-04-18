require "pry"
require "rspec"
require "csv"
require "./lib/teams"
require "simplecov"
SimpleCov.start
require_relative "../lib/stat_tracker"
require_relative "../lib/teams"

RSpec.describe Teams do
  before :each do
    game_path = "./data/test_games.csv"
    team_path = "./data/test_teams.csv"
    game_teams_path = "./data/test_game_teams.csv"

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists and has attributes" do
    expect(@stat_tracker.teams).to be_a Teams
    expect(@stat_tracker.teams.team_id).to eq(@stat_tracker.stats_main[:teams][:team_id])
    expect(@stat_tracker.teams.franchiseid).to eq(@stat_tracker.stats_main[:teams][:franchiseid])
    expect(@stat_tracker.teams.teamname).to eq(@stat_tracker.stats_main[:teams][:teamname])
    expect(@stat_tracker.teams.abbreviation).to eq(@stat_tracker.stats_main[:teams][:abbreviation])
    expect(@stat_tracker.teams.stadium).to eq(@stat_tracker.stats_main[:teams][:stadium])
    expect(@stat_tracker.teams.link).to eq(@stat_tracker.stats_main[:teams][:link])
  end

end
