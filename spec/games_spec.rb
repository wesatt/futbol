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

  it "exists and has attributes" do
    expect(@stat_tracker.games).to be_a Games
    expect(@stat_tracker.games.game_id).to eq(@stat_tracker.stats_main[:games][:game_id])
    expect(@stat_tracker.games.season).to eq(@stat_tracker.stats_main[:games][:season])
    expect(@stat_tracker.games.type).to eq(@stat_tracker.stats_main[:games][:type])
    expect(@stat_tracker.games.date_time).to eq(@stat_tracker.stats_main[:games][:date_time])
    expect(@stat_tracker.games.away_team_id).to eq(@stat_tracker.stats_main[:games][:away_team_id])
    expect(@stat_tracker.games.home_team_id).to eq(@stat_tracker.stats_main[:games][:home_team_id])
    expect(@stat_tracker.games.away_goals).to eq(@stat_tracker.stats_main[:games][:away_goals])
    expect(@stat_tracker.games.home_goals).to eq(@stat_tracker.stats_main[:games][:home_goals])
    expect(@stat_tracker.games.venue).to eq(@stat_tracker.stats_main[:games][:venue])
    expect(@stat_tracker.games.venue_link).to eq(@stat_tracker.stats_main[:games][:venue_link])
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
