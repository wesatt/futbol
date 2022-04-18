require "csv"
require_relative "./game_teams"
require_relative "./games"
require_relative "./teams"

class StatTracker
  attr_reader :teams, :game_teams, :games, :teams_csv

  def initialize(stat_tracker)
    @games = Games.new(stat_tracker[:games])
    # binding.pry
    @teams = Teams.new(stat_tracker[:teams])
    @game_teams = GameTeams.new(stat_tracker[:game_teams])
  end

  def self.from_csv(locations)
    stats = {}
    locations.each do |file_key, location_value|
      file = CSV.read(location_value, headers: true, header_converters: :symbol)
      stats[file_key] = file
    end
    StatTracker.new(stats)

    # stat_tracker = StatTracker.new(locations)
    # stat_tracker.games = Game.create_list_of_game(stat_tracker.games_csv)
  end


    def team_info(team_id)
      teams.by_id(team_id)
    end

  # Start Game Statistics methods
  def highest_total_score
    @games.total_scores.max
  end

  def lowest_total_score
    @games.total_scores.min
  end

  def percentage_home_wins
    (@games.game_outcomes[:home_win].to_f / @games.game_outcomes[:total].to_f).round(2)
  end

  def percentage_visitor_wins
    (@games.game_outcomes[:away_win].to_f / @games.game_outcomes[:total].to_f).round(2)
  end

  def percentage_ties
    (@games.game_outcomes[:tie].to_f / @games.game_outcomes[:total].to_f).round(2)
  end

  def count_of_games_by_season
    @games.games_by_season_hash[:count]
  end

  def average_goals_per_game
    (@games.total_scores.sum.to_f / @games.total_scores.count.to_f).round(2)
  end

  def average_goals_by_season
    @games.games_by_season_hash[:average_goals]
  end
  # End Game Statistics methods

  #league statistics methods
  def count_of_teams
    @teams.hash_data.length
  end

  def best_offense
  game_teams = @game_teams.hash_data
  team_data = {}
  game_teams.each do |game|
    if !team_data[game[:team_id]].nil?
      incrementer = team_data[game[:team_id]][:goals].to_i + game[:goals].to_i
      incrementer2 = team_data[game[:team_id]][:total_games].to_i + 1
      team_data[game[:team_id]] = {goals: incrementer, total_games: incrementer2}
    else
      incrementer = game[:goals].to_i
      team_data[game[:team_id]] = {goals: incrementer, total_games: 1}
    end
  end
  team_average_goals = Hash.new(0)
  team_data.each do |id_key, value_hash|
    @teams.team_id.each_with_index do |team_id, index|
      if team_id == id_key
        team_average_goals[@teams.teamname[index]] = (value_hash[:goals].to_f / value_hash[:total_games].to_f).round(2)
      end
    end
  end
  best_team = team_average_goals.max_by { |k, v| v }
  best_team[0]
  end

  def worst_offense
  game_teams = @game_teams.hash_data
  team_data = {}
  game_teams.each do |game|
    if !team_data[game[:team_id]].nil?
      incrementer = team_data[game[:team_id]][:goals].to_i + game[:goals].to_i
      incrementer2 = team_data[game[:team_id]][:total_games].to_i + 1
      team_data[game[:team_id]] = {goals: incrementer, total_games: incrementer2}
    else
      incrementer = game[:goals].to_i
      team_data[game[:team_id]] = {goals: incrementer, total_games: 1}
    end
  end
  team_average_goals = Hash.new(0)
  team_data.each do |id_key, value_hash|
    @teams.team_id.each_with_index do |team_id, index|
      if team_id == id_key
        team_average_goals[@teams.teamname[index]] = (value_hash[:goals].to_f / value_hash[:total_games].to_f).round(2)
      end
    end
  end
  best_team = team_average_goals.min_by { |k, v| v }
  best_team[0]
  end

  def highest_scoring_visitor
    game_teams = @game_teams.hash_data
    team_data = {}
    game_teams.each do |game|
      if game[:hoa] == "away"
        if !team_data[game[:team_id]].nil?
          away_goals_incrementer = team_data[game[:team_id]][:goals].to_i + game[:goals].to_i
          away_goals_incrementer2 = team_data[game[:team_id]][:total_games].to_i + 1
          team_data[game[:team_id]] = {goals: away_goals_incrementer, total_games: away_goals_incrementer2}
        else
          away_goals_incrementer = game[:goals].to_i
          team_data[game[:team_id]] = {goals: away_goals_incrementer, total_games: 1}
        end
      end
    end
    team_average_goals = Hash.new(0)
    team_data.each do |id_key, value_hash|
      @teams.team_id.each_with_index do |team_id, index|
        if team_id == id_key
          team_average_goals[@teams.teamname[index]] = (value_hash[:goals].to_f / value_hash[:total_games].to_f).round(2)
        end
      end
    end
    best_team = team_average_goals.max_by { |k, v| v }
    best_team[0]
  end

  def lowest_scoring_visitor
    game_teams = @game_teams.hash_data
    team_data = {}
    game_teams.each do |game|
      if game[:hoa] == "away"
        if !team_data[game[:team_id]].nil?
          away_goals_incrementer = team_data[game[:team_id]][:goals].to_i + game[:goals].to_i
          away_goals_incrementer2 = team_data[game[:team_id]][:total_games].to_i + 1
          team_data[game[:team_id]] = {goals: away_goals_incrementer, total_games: away_goals_incrementer2}
        else
          away_goals_incrementer = game[:goals].to_i
          team_data[game[:team_id]] = {goals: away_goals_incrementer, total_games: 1}
        end
      end
    end
    team_average_goals = Hash.new(0)
    team_data.each do |id_key, value_hash|
      @teams.team_id.each_with_index do |team_id, index|
        if team_id == id_key
          team_average_goals[@teams.teamname[index]] = (value_hash[:goals].to_f / value_hash[:total_games].to_f).round(2)
        end
      end
    end
    best_team = team_average_goals.min_by { |k, v| v }
    best_team[0]
  end

  def highest_scoring_home_team
    game_teams = @game_teams.hash_data
    team_data = {}
    game_teams.each do |game|
      if game[:hoa] == "home"
        if !team_data[game[:team_id]].nil?
          away_goals_incrementer = team_data[game[:team_id]][:goals].to_i + game[:goals].to_i
          away_goals_incrementer2 = team_data[game[:team_id]][:total_games].to_i + 1
          team_data[game[:team_id]] = {goals: away_goals_incrementer, total_games: away_goals_incrementer2}
        else
          away_goals_incrementer = game[:goals].to_i
          team_data[game[:team_id]] = {goals: away_goals_incrementer, total_games: 1}
        end
      end
    end
    team_average_goals = Hash.new(0)
    team_data.each do |id_key, value_hash|
      @teams.team_id.each_with_index do |team_id, index|
        if team_id == id_key
          team_average_goals[@teams.teamname[index]] = (value_hash[:goals].to_f / value_hash[:total_games].to_f).round(2)
        end
      end
    end
    best_team = team_average_goals.max_by { |k, v| v }
    best_team[0]
  end

  def lowest_scoring_home_team
    game_teams = @game_teams.hash_data
    team_data = {}
    game_teams.each do |game|
      if game[:hoa] == "home"
        if !team_data[game[:team_id]].nil?
          away_goals_incrementer = team_data[game[:team_id]][:goals].to_i + game[:goals].to_i
          away_goals_incrementer2 = team_data[game[:team_id]][:total_games].to_i + 1
          team_data[game[:team_id]] = {goals: away_goals_incrementer, total_games: away_goals_incrementer2}
        else
          away_goals_incrementer = game[:goals].to_i
          team_data[game[:team_id]] = {goals: away_goals_incrementer, total_games: 1}
        end
      end
    end
    team_average_goals = Hash.new(0)
    team_data.each do |id_key, value_hash|
      @teams.team_id.each_with_index do |team_id, index|
        if team_id == id_key
          team_average_goals[@teams.teamname[index]] = (value_hash[:goals].to_f / value_hash[:total_games].to_f).round(2)
        end
      end
    end
    best_team = team_average_goals.min_by { |k, v| v }
    best_team[0]
  end
end
