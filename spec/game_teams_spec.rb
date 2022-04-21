require "pry"
require "rspec"
require "csv"
require "simplecov"
SimpleCov.start
require_relative "../lib/stat_tracker"
require_relative "../lib/games"
require_relative "../lib/teams"
require_relative "../lib/game_teams"

RSpec.describe GameTeams do
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
    expect(@stat_tracker.game_teams).to be_a GameTeams
  end

  it "has game_id" do
    expect = ["2012020001", "2012020001", "2012020002", "2012020002", "2012020003",
      "2012020003", "2012020004", "2012020004", "2012020005", "2012020005", "2012020006",
      "2012020006", "2012020007", "2012020007", "2012020008", "2012020008", "2012020009",
      "2012020009", "2012020010", "2012020010", "2012020011", "2012020011", "2012020012",
      "2012020012", "2012020013", "2012020013", "2012020014", "2012020014", "2012020015",
      "2012020015", "2012020016", "2012020016", "2012020017", "2012020017", "2012020018",
      "2012020018", "2012020019", "2012020019", "2012020020", "2012020020", "2012020122",
      "2012020122", "2012020225", "2012020225", "2012020387", "2012020387", "2012020510",
      "2012020510", "2012020577", "2012020577", "2012030221", "2012030221", "2012030222",
      "2012030222", "2012030223", "2012030223", "2012030224", "2012030224", "2012030225",
      "2012030225", "2012030231", "2012030231", "2012030311", "2012030311", "2012030312",
      "2012030312", "2012030313", "2012030313", "2012030314", "2012030314"]
    expect(@stat_tracker.game_teams.game_id).to eq(expect)
  end

  it "has team_id" do
    expect = ["5", "4", "52", "9", "26", "16", "6", "3", "8", "10", "2", "1", "15",
      "14", "13", "12", "19", "17", "18", "29", "27", "25", "21", "30", "23", "24",
      "7", "4", "5", "3", "20", "28", "25", "30", "23", "22", "27", "16", "6", "52",
      "1", "2", "29", "24", "26", "27", "26", "30", "12", "6", "3", "6", "3", "6",
      "6", "3", "6", "3", "3", "6", "17", "16", "6", "5", "6", "5", "5", "6", "5", "6"]
    expect(@stat_tracker.game_teams.team_id).to eq(expect)
  end

  it "has head coach" do
    expect = ["Dan Bylsma", "Peter Laviolette", "Claude Noel", "Paul MacLean",
      "Darryl Sutter", "Joel Quenneville", "Claude Julien", "John Tortorella",
      "Michel Therrien", "Randy Carlyle", "Jack Capuano", "Peter DeBoer", "Adam Oates",
      "Guy Boucher", "Kevin Dineen", "Kirk Muller", "Ken Hitchcock", "Mike Babcock",
      "Barry Trotz", "Todd Richards", "Dave Tippett", "Glen Gulutzan", "Joe Sacco",
      "Mike Yeo", "Alain Vigneault", "Bruce Boudreau", "Lindy Ruff", "Peter Laviolette",
      "Dan Bylsma", "John Tortorella", "Bob Hartley", "Todd McLellan", "Glen Gulutzan",
      "Mike Yeo", "Alain Vigneault", "Ralph Krueger", "Dave Tippett", "Joel Quenneville",
      "Claude Julien", "Claude Noel", "Peter DeBoer", "Jack Capuano", "Todd Richards",
      "Bruce Boudreau", "Darryl Sutter", "Dave Tippett", "Darryl Sutter", "Mike Yeo",
      "Kirk Muller", "Claude Julien", "John Tortorella", "Claude Julien", "John Tortorella",
      "Claude Julien", "Claude Julien", "John Tortorella", "Claude Julien", "John Tortorella",
      "John Tortorella", "Claude Julien", "Mike Babcock", "Joel Quenneville", "Claude Julien",
      "Dan Bylsma", "Claude Julien", "Dan Bylsma", "Dan Bylsma", "Claude Julien", "Dan Bylsma",
      "Claude Julien"]
    expect(@stat_tracker.game_teams.head_coach).to eq(expect)
  end

  it "has goals" do
    expect = ["3", "1", "1", "2", "2", "3", "3", "1", "1", "2", "1", "2", "3",
      "4", "3", "1", "4", "0", "2", "2", "3", "2", "2", "2", "3", "5", "3", "2",
      "4", "3", "1", "2", "0", "1", "2", "2", "2", "4", "1", "1", "3", "0", "2",
      "3", "2", "3", "3", "3", "2", "4", "2", "3", "2", "3", "2", "1", "3", "2",
      "1", "3", "1", "2", "3", "0", "4", "1", "1", "2", "0", "1"]
    expect(@stat_tracker.game_teams.goals).to eq(expect)
  end

  it "has shots" do
    expect = ["6", "6", "7", "9", "5", "5", "8", "5", "5", "6", "4", "7", "7",
      "8", "6", "10", "9", "3", "8", "7", "10", "6", "6", "8", "7", "6", "10",
      "7", "9", "8", "8", "7", "6", "8", "7", "8", "7", "7", "6", "6", "6", "5",
      "6", "7", "8", "7", "7", "7", "10", "9", "8", "12", "9", "8", "8", "6",
      "10", "8", "7", "8", "5", "10", "7", "7", "7", "6", "13", "10", "6", "6"]
    expect(@stat_tracker.game_teams.shots).to eq(expect)
  end
end
