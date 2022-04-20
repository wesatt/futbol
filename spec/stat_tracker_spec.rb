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

  # Start Game Statistics tests
  it "checks highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 6
  end

  it "checks lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 1
  end

  it "checks percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.5
  end

  it "checks percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.35
  end

  it "checks percentage_ties" do
    expect(@stat_tracker.percentage_ties).to eq 0.15
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

  it "checks average_goals_by_season" do
    expect = {
      "20122013" => 4.13,
      "20132014" => 4.20
    }
    expect(@stat_tracker.average_goals_by_season).to eq(expect)
  end
  # End Game Statistics tests

  # Start League statistics tests
  it "#count_of_teams" do
    expect(@stat_tracker.count_of_teams).to eq 32
  end

  it "#best_offense" do
    expect(@stat_tracker.best_offense).to eq "DC United"
  end

  it "#worst_offense" do
    expect(@stat_tracker.worst_offense).to eq "Seattle Sounders FC"
  end

  it "#highest_scoring_visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq "Real Salt Lake"
  end

  it "#highest_scoring_home_team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq "DC United"
  end

  it "#lowest_scoring_visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq "Chicago Red Stars"
  end

  it "#lowest_scoring_home_team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq "Seattle Sounders FC"
  end
  # End of League Statistics tests

  # Start Season Statistics tests
  it "has a winningest coach" do
    expect(@stat_tracker.winningest_coach("20122013")).to eq("Peter DeBoer")
  end

  it "has worst coach" do
    expect(@stat_tracker.worst_coach("20122013")).to eq("Jack Capuano")
  end

  it "has most accurate team by season" do
    expect(@stat_tracker.most_accurate_team("20122013")).to eq("Atlanta United")
  end

  it "has least accurate team by season" do
    expect(@stat_tracker.least_accurate_team("20122013")).to eq("Seattle Sounders FC")
  end

  it "has most tackles in the season" do
    expect(@stat_tracker.most_tackles("20122013")).to eq("FC Dallas")
  end

  it "has fewest tackles in the season" do
    expect(@stat_tracker.fewest_tackles("20122013")).to eq("Atlanta United")
  end
  # end of season statistics methods

  # Start Team methods
  it "returns a hash for team info" do
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    expect(@stat_tracker.team_info("18")).to eq(expected)
  end

  it "shows the season with the highest win percentage for a team" do
    expect(@stat_tracker.best_season("6")).to eq("20122013")
  end

  it "shows the season with the highest win percentage for a team" do
    expect(@stat_tracker.worst_season("6")).to eq("20122013")
  end

  it "will show a teams average win percentage of all games" do
    expect(@stat_tracker.average_win_percentage("5")).to eq(0.33)
  end

  it "will show the highest score of a particular team has scored in a game" do
    expect(@stat_tracker.most_goals_scored("16")).to eq(4)
  end

  it "will show the lowest goals scored for a particular team in a game" do
    expect(@stat_tracker.fewest_goals_scored("16")).to eq(2)
  end

  it "shows a string of opponent that has the lowest win percentage versus given team" do
    expect(@stat_tracker.favorite_opponent("6")).to eq("Houston Dynamo")
  end

  it "shows a string of opponent that has the highest win percentage versus given team" do
    expect(@stat_tracker.rival("6")).to eq("Atlanta United")
  end
  # end Team methods
end
