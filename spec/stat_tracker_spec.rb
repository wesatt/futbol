require "pry"
require "rspec"
require "csv"
require "simplecov"
SimpleCov.start
require_relative "../lib/stat_tracker"
require_relative "../lib/games"
require_relative "../lib/teams"
require_relative "../lib/game_teams"

RSpec.describe StatTracker do
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
    expect(@stat_tracker).to be_a StatTracker
  end

  # Start Game Statistics methods
  it "checks highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 6
  end

  it "checks lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 1
  end

  it "checks percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq 50.00
  end

  it "checks percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq 35.00
  end

  it "checks percentage_ties" do
    expect(@stat_tracker.percentage_ties).to eq 15.00
  end

  it "checks count_of_games_by_season" do
    expect = {
      "20122013" => 15,
      "20132014" => 5
    }
    expect(@stat_tracker.count_of_games_by_season).to eq(expect)
  end

  it "checks average_goals_per_game" do
    expect(@stat_tracker.average_goals_per_game).to eq 4.15
  end

  xit "checks average_goals_by_season" do
    # Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)
    # Hash
  end
  # End Game Statistics methods
end
