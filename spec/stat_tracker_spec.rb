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

    # game_path = "./data/games.csv"
    # team_path = "./data/teams.csv"
    # game_teams_path = "./data/game_teams.csv"

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

  # start league statistics
  xit "#count_of_teams" do
    expect(@stat_tracker.count_of_teams).to eq 32
  end

  it "#best_offense" do
    expect(@stat_tracker.best_offense).to eq "DC United"
    # expect(@stat_tracker.best_offense).to eq "Reign FC"
  end

  xit "#worst_offense" do
    expect(@stat_tracker.worst_offense).to eq "Seattle Sounders FC"
    # expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
  end

  xit "#highest_scoring_visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq "Real Salt Lake"
    # expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
  end

  xit "#highest_scoring_home_team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq "DC United"
    # expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  end

  xit "#lowest_scoring_visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq "Chicago Red Stars"
    # expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end

  xit "#lowest_scoring_home_team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq "Seattle Sounders FC"
    # expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
  end
  # end of league statistics

  # Start Game Statistics methods
  xit "checks highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 6
  end

  xit "checks lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 1
  end

  xit "checks percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.5
  end

  xit "checks percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.35
  end

  xit "checks percentage_ties" do
    expect(@stat_tracker.percentage_ties).to eq 0.15
  end

  xit "checks count_of_games_by_season" do
    expect = {
      "20122013" => 15,
      "20132014" => 5
    }
    expect(@stat_tracker.count_of_games_by_season).to eq(expect)
  end

  xit "checks average_goals_per_game" do
    expect(@stat_tracker.average_goals_per_game).to eq 4.15
  end

  xit "checks average_goals_by_season" do
    expect = {
      "20122013" => 4.13,
      "20132014" => 4.20
    }
    expect(@stat_tracker.average_goals_by_season).to eq(expect)
  end
  # End Game Statistics methods

  # Start Season Statistics methods
  xit "has a winningest coach" do
    # expect(@stat_tracker.winningest_coach("20122013")).to eq("Adam Oates")
    expect(@stat_tracker.winningest_coach("20132014")).to eq("Claude Julien")
    expect(@stat_tracker.winningest_coach("20142015")).to eq("Alain Vigneault")
  end

  xit "has worst coach" do
    expect(@stat_tracker.worst_coach("20132014")).to eq("Peter DeBoer")
    # expect(@stat_tracker.worst_coach("20132014")).to eq("Peter Laviolette")
    # expect(@stat_tracker.worst_coach("20142015")).to eq ("Craig MacTavish") | eq("Ted Nolan")
  end

  xit "has most accurate team by season" do
    expect(@stat_tracker.most_accurate_team("20122013")).to eq("Atlanta United")
    # expect(@stat_tracker.most_accurate_team("20132014")).to eq("Real Salt Lake")
    # expect(@stat_tracker.most_accurate_team("20142015")).to eq("Toronto FC")
  end

  xit "has least accurate team by season" do
    expect(@stat_tracker.least_accurate_team("20122013")).to eq("Seattle Sounders FC")
    # expect(@stat_tracker.least_accurate_team("20132014")).to eq("New York City FC")
    # expect(@stat_tracker.least_accurate_team("20142015")).to eq("Columbus Crew SC")
  end

  xit "has most tackles in the season" do
    expect(@stat_tracker.most_tackles("20132014")).to eq("FC Cincinnati")
    expect(@stat_tracker.most_tackles("20142015")).to eq("Seattle Sounders FC")
    # expect(@stat_tracker.most_tackles("20142015")).to eq ()
  end
  # end of season statistics methods

  # Start Team methods
  it "returns a hash for team info" do
    expected = {team_id: "4", franchiseid: "16", teamname: "Chicago Fire", abbreviation: "CHI", stadium: "SeatGeek Stadium", link: "/api/v1/teams/4"}

    expect(@stat_tracker.team_info(4)).to eq(expected)
  end

  xit "shows the season with the highest win percentage for a team" do
    # Need the win percentage method and be able to use the team_id

    expect(@stat_tracker.best_season(30)).to eq("20122013")
  end

  xit "will show the highest score of a particular team" do
    expect(@stat_tracker.most_goals_scored(16)).to eq(4)
  end

  it 'will show a teams average win percentage of all games' do
    expect(@stat_tracker.average_win_percentage(5)).to eq(0.33)
  end
  # end Team methods
end
