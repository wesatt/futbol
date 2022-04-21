require "pry"
require "rspec"
require "csv"
require "simplecov"
SimpleCov.start
require_relative "../lib/stat_tracker"
require_relative "../lib/games"
require_relative "../lib/teams"
require_relative "../lib/game_teams"

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

  it "exists" do
    expect(@stat_tracker.teams).to be_a Teams
  end

  it "shows the teamname from teams files" do
    expect(@stat_tracker.teams.team_name_by_id("5")).to eq("Sporting Kansas City")
  end

  it "shows the team ids in an array from teams file" do
    expected = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "52", "53", "54"]
    expect(@stat_tracker.teams.team_id).to eq(expected)
  end

  it "shows an array  of the team names as strings from teams file" do
    expected = ["Atlanta United", "Seattle Sounders FC", "Houston Dynamo", "Chicago Fire", "Sporting Kansas City", "FC Dallas", "Utah Royals FC", "New York Red Bulls", "New York City FC", "North Carolina Courage", "Sky Blue FC", "Houston Dash", "DC United", "Portland Timbers", "New England Revolution", "LA Galaxy", "Minnesota United FC", "Philadelphia Union", "Toronto FC", "Vancouver Whitecaps FC", "Washington Spirit FC", "Montreal Impact", "Real Salt Lake", "Chicago Red Stars", "FC Cincinnati", "San Jose Earthquakes", "Los Angeles FC", "Orlando Pride", "Orlando City SC", "Portland Thorns FC", "Columbus Crew SC", "Reign FC"]

    expect(@stat_tracker.teams.teamname).to eq(expected)
  end
end
