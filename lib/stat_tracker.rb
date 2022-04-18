require "pry"
require "csv"
require_relative "./game_teams"
require_relative "./games"
require_relative "./teams"

class StatTracker
  attr_reader :teams, :game_teams, :games, :teams_csv

  def initialize(stat_tracker)
    @games = Games.new(stat_tracker[:games])
    @teams = Teams.new(stat_tracker[:teams])
    @game_teams = GameTeams.new(stat_tracker[:game_teams])
  end

  def self.from_csv(locations)
    stats = {}
    locations.each do |file_key, location_value|
      csv = CSV.read(location_value, headers: true, header_converters: :symbol)
      stats[file_key] = csv.map { |row| row.to_h }
    end
    StatTracker.new(stats)

    # stat_tracker = StatTracker.new(locations)
    # stat_tracker.games = Game.create_list_of_game(stat_tracker.games_csv)
  end

  def team_info(team_id)
    teams.by_id(team_id)
  end

  def best_season(team_id_number)
    # creates hash with team ids as keys and an empty hash as the value
    team_id_hash = Hash.new(0)
    win_percentage_hash = Hash.new(0)
    @teams.team_id.each do |team|
      team_id_hash[team] = Hash.new(0)
      win_percentage_hash[team] = Hash.new(0)
    end

    # for each team id in team_id_hash creates a hash with seasons as keys and the value is a hash with win/lose/tie/total keys
    @games.season.each_with_index do |season, index|
      team_id_hash.each do |key, value|
        if @games.away_team_id[index] == key
          team_id_hash[@games.away_team_id[index]][season] = {win: 0, lose: 0, tie: 0, total: 0}
        elsif @games.home_team_id[index] == key
          team_id_hash[@games.home_team_id[index]][season] = {win: 0, lose: 0, tie: 0, total: 0}
        end
      end
    end

    # adds win/lose/tie/total to each season
    @games.away_goals.each_with_index do |score, index|
      if score.to_i > @games.home_goals[index].to_i
        team_id_hash[@games.away_team_id[index]][@games.season[index]][:win] += 1
        team_id_hash[@games.home_team_id[index]][@games.season[index]][:lose] += 1
      elsif score.to_i < @games.home_goals[index].to_i
        team_id_hash[@games.home_team_id[index]][@games.season[index]][:win] += 1
        team_id_hash[@games.away_team_id[index]][@games.season[index]][:lose] += 1
      elsif score.to_i == @games.home_goals[index].to_i
        team_id_hash[@games.home_team_id[index]][@games.season[index]][:tie] += 1
        team_id_hash[@games.away_team_id[index]][@games.season[index]][:tie] += 1
      end
      team_id_hash[@games.away_team_id[index]][@games.season[index]][:total] += 1
      team_id_hash[@games.home_team_id[index]][@games.season[index]][:total] += 1
    end

    # adds win percentage based on win/total
    team_id_hash.each do |team_id_key, season_hash_values|
      season_hash_values.each do |season_key, hash_values|
        win_percentage = (hash_values[:win].to_f / hash_values[:total].to_f).round(2)
        hash_values[:win_percentage] = win_percentage
      end
    end

    # creates a hash of team id with a hash of season => win_percentage key/value pairs
    team_id_hash.each do |id_key, season_value|
      season_value.each do |season, values|
        win_percentage_hash[id_key][season] = values[:win_percentage]
      end
    end

    # returns the highest winning percent season
    best = win_percentage_hash[team_id_number.to_s].max_by { |k, v| v }
    best[0]
  end

  def most_goals_scored(team_id)
    # @game_teams.goals_array(team_id).max
    # max_goals = {}
    # goals_by_id = []
    # @game_teams.each do |row|
    #   team_hash = row.to_h
    #   max_goals[team_hash[:team_id]] = goals_by_id
    #   if team_hash[:team_id] == team_id
    #     goals_by_id << team_hash[:goals]
    #   end
    # end
    # max_goals[team_id].max

    # max_goals = Hash.new
    # goals_by_id = Array.new
    #
    # game_teams.gt_by_id(team_id).find_all
    #   max_goals[team_id] = goals_by_id
    #   goals_by_id << game_teams.gt_by_id(team_id)[:goals]
    #   max_goals[team_id].max.to_i
  end

  #   def winningest_coach(season_arg)
  #     coach_by_season = Hash.new(0)
  #     team_id_for_season = Hash.new(0)
  #     @teams.team_id.each do |team|
  #       team_id_for_season[team] = {win: 0, total: 0}
  #     end

  #     # adds wins and totals
  #     @games.season.each_with_index do |season, index|
  #       if season == season_arg
  #         if @games.away_goals[index].to_i > @games.home_goals[index].to_i
  #           team_id_for_season[@games.away_team_id[index]][:win] += 1
  #         elsif @games.away_goals[index].to_i < @games.home_goals[index].to_i
  #           team_id_for_season[@games.home_team_id[index]][:win] += 1
  #         end
  #         team_id_for_season[@games.away_team_id[index]][:total] += 1
  #         team_id_for_season[@games.home_team_id[index]][:total] += 1
  #       end
  #     end

  #     # adds coach
  #     team_id_for_season.each do |key_id, value_hash|
  #       @game_teams.head_coach.each_with_index do |coach, index|
  #         team_id_for_season[@game_teams.team_id[index]][:coach] = coach
  #       end
  #     end

  #     # makes hash of coaches and wins
  #     team_id_for_season.each do |key_id, value_hash|
  #       percentage = (value_hash[:win].to_f / value_hash[:total].to_f)
  #       coach_by_season[value_hash[:coach]] = if percentage > 0
  #         percentage
  #       else
  #         0
  #       end
  #     end

  #     best_coach = coach_by_season.max_by { |k, v| v }
  #     best_coach[0]
  #   end

  def worst_coach(season_arg)
    coach_by_season = Hash.new(0)
    team_id_for_season = Hash.new(0)
    @teams.team_id.each do |team|
      team_id_for_season[team] = {loss: 0, total: 0}
    end

    # adds losss and totals
    @games.season.each_with_index do |season, index|
      if season == season_arg
        if @games.away_goals[index].to_i > @games.home_goals[index].to_i
          team_id_for_season[@games.away_team_id[index]][:loss] += 1
        elsif @games.away_goals[index].to_i < @games.home_goals[index].to_i
          team_id_for_season[@games.home_team_id[index]][:loss] += 1
        end
        team_id_for_season[@games.away_team_id[index]][:total] += 1
        team_id_for_season[@games.home_team_id[index]][:total] += 1
      end
    end

    # adds coach
    team_id_for_season.each do |key_id, value_hash|
      @game_teams.head_coach.each_with_index do |coach, index|
        team_id_for_season[@game_teams.team_id[index]][:coach] = coach
      end
    end

    # makes hash of coaches and losss
    team_id_for_season.each do |key_id, value_hash|
      percentage = (value_hash[:loss].to_f / value_hash[:total].to_f)
      coach_by_season[value_hash[:coach]] = if percentage > 0
        percentage
      else
        0
      end
    end
    worst_coach = coach_by_season.min_by { |k, v| v }
    worst_coach[0]
  end

  def most_accurate_team(season_arg)
    game_id_array = []
    @games.season.each_with_index do |season, index|
      if season == season_arg
        game_id_array << @games.game_id[index]
      end
    end
    team_goals_hash = Hash.new(0)
    @game_teams.game_id.each_with_index do |game_id, index|
      if game_id_array.include?(game_id)
        if team_goals_hash[@game_teams.team_id[index]] != 0
          team_goals_hash[@game_teams.team_id[index]][:goals] += @game_teams.goals[index].to_i
          team_goals_hash[@game_teams.team_id[index]][:shots] += @game_teams.shots[index].to_i
        else
          team_goals_hash[@game_teams.team_id[index]] = Hash.new(0)
          team_goals_hash[@game_teams.team_id[index]][:goals] = @game_teams.goals[index].to_i
          team_goals_hash[@game_teams.team_id[index]][:shots] = @game_teams.shots[index].to_i
        end
      end
    end
    team_name_goals_ratio = Hash.new(0)
    team_goals_hash.each do |team_id2, values|
      @teams.team_id.each_with_index do |team_id1, index|
        if team_id2 == team_id1
          team_name_goals_ratio[@teams.teamname[index]] =
            (team_goals_hash[team_id2][:goals].to_f / team_goals_hash[team_id2][:shots].to_f)
        end
      end
    end
    accurate_team = team_name_goals_ratio.max_by { |k, v| v }
    accurate_team[0]
  end

  def least_accurate_team(season_arg)
    game_id_array = []
    @games.season.each_with_index do |season, index|
      if season == season_arg
        game_id_array << @games.game_id[index]
      end
    end
    team_goals_hash = Hash.new(0)
    @game_teams.game_id.each_with_index do |game_id, index|
      if game_id_array.include?(game_id)
        if team_goals_hash[@game_teams.team_id[index]] != 0
          team_goals_hash[@game_teams.team_id[index]][:goals] += @game_teams.goals[index].to_i
          team_goals_hash[@game_teams.team_id[index]][:shots] += @game_teams.shots[index].to_i
        else
          team_goals_hash[@game_teams.team_id[index]] = Hash.new(0)
          team_goals_hash[@game_teams.team_id[index]][:goals] = @game_teams.goals[index].to_i
          team_goals_hash[@game_teams.team_id[index]][:shots] = @game_teams.shots[index].to_i
        end
      end
    end
    team_name_goals_ratio = Hash.new(0)
    team_goals_hash.each do |team_id2, values|
      @teams.team_id.each_with_index do |team_id1, index|
        if team_id2 == team_id1
          team_name_goals_ratio[@teams.teamname[index]] =
            (team_goals_hash[team_id2][:goals].to_f / team_goals_hash[team_id2][:shots].to_f)
        end
      end
    end
    accurate_team = team_name_goals_ratio.min_by { |k, v| v }
    accurate_team[0]
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

  def game_ids_by_season(season_id)
    game_id_array = []
    @games.season.each_with_index do |season, index|
      if season == season_id
        game_id_array << @games.game_id[index]
      end
    end
    game_id_array
  end

  def winningest_coach(season_arg)
    games_grouped_by_game_id = @game_teams.data.group_by do |game|
      game[:game_id]
    end

    list_of_games_by_season = []
    game_ids_by_season(season_arg).each do |game_id|
      list_of_games_by_season << games_grouped_by_game_id[game_id]
    end

    games_grouped_by_coach = list_of_games_by_season.flatten.group_by do |game|
      game[:head_coach]
    end

    coach_wins = Hash.new(0)
    games_grouped_by_coach.each do |coach, coach_game_array|
      coach_wins[coach] = {win: 0, total: 0}
      coach_game_array.each do |game|
        if game[:result] == "WIN"
          coach_wins[coach][:win] += 1
        end
        coach_wins[coach][:total] += 1
      end
    end

    best_coach = coach_wins.max_by do |key, value|
      (value[:win].to_f / value[:total].to_f)
    end

    worst_coach = coach_wins.min_by do |key, value|
      (value[:win].to_f / value[:total].to_f)
    end

    best_coach[0]
  end

  # league statistics methods
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
  # End Season Statistics methods
end
