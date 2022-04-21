require "pry"
require "rspec"
require "csv"
require "simplecov"
SimpleCov.start
require_relative "../lib/stat_tracker"
require_relative "../lib/games"
require_relative "../lib/teams"
require_relative "../lib/game_teams"

RSpec.describe Games do
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
    expect(@stat_tracker.games).to be_a Games
  end

  it "has game id" do
    expect = ["2012020122",
      "2012020225",
      "2012020387",
      "2012020510",
      "2012020577",
      "2012030221",
      "2012030222",
      "2012030223",
      "2012030224",
      "2012030225",
      "2012030231",
      "2012030311",
      "2012030312",
      "2012030313",
      "2012030314",
      "2013020177",
      "2013020674",
      "2013020704",
      "2013021036",
      "2013021085"]
    expect(@stat_tracker.games.game_id).to eq(expect)
  end

  it "has seasons" do
    expect = ["20122013",
      "20122013",
      "20122013",
      "20122013",
      "20122013",
      "20122013",
      "20122013",
      "20122013",
      "20122013",
      "20122013",
      "20122013",
      "20122013",
      "20122013",
      "20122013",
      "20122013",
      "20132014",
      "20132014",
      "20132014",
      "20132014",
      "20132014"]
    expect(@stat_tracker.games.season).to eq(expect)
  end

  it "has away team id" do
    expect = ["1", "29", "26", "26", "12", "3", "3", "6", "6", "3", "17",
      "6", "6", "5", "5", "24", "19", "20", "15", "17"]
    expect(@stat_tracker.games.away_team_id).to eq(expect)
  end

  it "has home team id" do
    expect = ["2", "24", "27", "30", "6", "6", "6", "3", "3", "6", "16",
      "5", "5", "6", "6", "4", "23", "18", "24", "29"]
    expect(@stat_tracker.games.home_team_id).to eq(expect)
  end

  it "has away goals" do
    expect = ["3", "2", "2", "3", "2", "2", "2", "2", "3", "1", "1", "3",
      "4", "1", "0", "3", "1", "2", "3", "2"]
    expect(@stat_tracker.games.away_goals).to eq(expect)
  end

  it "has home goals" do
    expect = ["0", "3", "3", "3", "4", "3", "3", "1", "2", "3", "2", "0",
      "1", "2", "1", "2", "2", "2", "2", "2"]
    expect(@stat_tracker.games.home_goals).to eq(expect)
  end

  it "has array of total scores for each game" do
    expect = [3, 5, 5, 6, 6, 5, 5, 3, 5, 4, 3, 3, 5, 3, 1, 5, 3, 4, 5, 4]
    expect(@stat_tracker.games.total_scores).to eq(expect)
  end

  it "checks and counts game outcomes (home win/away win/tie)" do
    expect = {
      home_win: 10,
      away_win: 7,
      tie: 3,
      total: 20
    }
    expect(@stat_tracker.games.game_outcomes).to eq(expect)
  end

  it "creates games_by_season_hash" do
    expect1 = {
      "20122013" => 15,
      "20132014" => 5
    }

    expect2 = {
      "20122013" => 4.13,
      "20132014" => 4.20
    }

    expect(@stat_tracker.games.games_by_season_hash[:count]).to eq(expect1)
    expect(@stat_tracker.games.games_by_season_hash[:average_goals]).to eq(expect2)
  end
end
