require "pry"
require "rspec"
require "csv"
require "simplecov"
SimpleCov.start
require_relative "../lib/stat_tracker"
require_relative "../lib/games"
require_relative "../lib/teams"
require_relative "../lib/game_teams"
require 'pry'

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



  it 'returns a hash for team info' do
    expected = {team_id: "4", franchiseid: "16", teamname: "Chicago Fire", abbreviation: "CHI", stadium: "SeatGeek Stadium", link: "/api/v1/teams/4"}

    expect(@stat_tracker.team_info(4)).to eq(expected)
  end

  xit 'shows the season with the highest win percentage for a team' do
    #Need the win percentage method and be able to use the team_id
    #One is coming from game_teams.csv and one from teams.csv
    expect(@stat_tracker.best_season(6)).to eq("20132014")
  end

  # Start Game Statistics methods
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
  # End Game Statistics methods
  # Start Season Statistics methods
  it 'has a winningest coach' do
    expect(@stat_tracker.winningest_coach('20132014')).to eq ("Clause Julien")
    expect(@stat_tracker.winningest_coach('20142015')).to eq ("Alain Vigneault")
  end

  it 'has worst coach' do
    expect(@stat_tracker.worst_coach('20132014')).to eq ("Peter DeBoer")
    expect(@stat_tracker.worst_coach('20142015')).to eq ("Craig MacTavish").or(eq("Ted Nolan"))
  end

end
