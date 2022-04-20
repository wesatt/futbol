require "pry"
require "csv"
require_relative "./game_teams"
require_relative "./games"
require_relative "./teams"

class StatTracker
  attr_reader :teams, :game_teams, :games

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

  # Start League Statistics methods
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
  # End League Statistics methods

  # Start Season Statistics methods
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
    best_coach[0]
  end

  def worst_coach(season_arg)
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
    worst_coach = coach_wins.min_by do |key, value|
      (value[:win].to_f / value[:total].to_f)
    end
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

  def most_tackles(season_id)
    games_grouped_by_game_id = @game_teams.data.group_by do |game|
      game[:game_id]
    end
    list_of_games_by_season = []
    game_ids_by_season(season_id).each do |game_id|
      list_of_games_by_season << games_grouped_by_game_id[game_id]
    end
    games_grouped_by_team_id = list_of_games_by_season.flatten.group_by do |game|
      game[:team_id]
    end
    team_tackles = Hash.new(0)
    games_grouped_by_team_id.each do |team, games|
      name = @teams.team_name_by_id(team)
      team_tackles[name] = 0
      games.each do |row|
        team_tackles[name] += row[:tackles].to_i
      end
    end
    most_tackles = team_tackles.max_by { |k, v| v }
    most_tackles[0]
  end

  def fewest_tackles(season_id)
    games_grouped_by_game_id = @game_teams.data.group_by do |game|
      game[:game_id]
    end
    list_of_games_by_season = []
    game_ids_by_season(season_id).each do |game_id|
      list_of_games_by_season << games_grouped_by_game_id[game_id]
    end
    games_grouped_by_team_id = list_of_games_by_season.flatten.group_by do |game|
      game[:team_id]
    end
    team_tackles = Hash.new(0)
    games_grouped_by_team_id.each do |team, games|
      name = @teams.team_name_by_id(team)
      team_tackles[name] = 0
      games.each do |row|
        team_tackles[name] += row[:tackles].to_i
      end
    end
    least_tackles = team_tackles.min_by { |k, v| v }
    least_tackles[0]
  end
  # End Season Statistics methods

  # Start Team Statistics methods
  def team_info(team_id)
    teams_by_group = @teams.data.group_by do |team|
      team[:team_id]
    end
    team = teams_by_group[team_id]
    team[0].delete(:stadium)
    team[0]["team_id"] = team[0].delete(:team_id)
    team[0]["franchise_id"] = team[0].delete(:franchiseid)
    team[0]["team_name"] = team[0].delete(:teamname)
    team[0]["abbreviation"] = team[0].delete(:abbreviation)
    team[0]["link"] = team[0].delete(:link)
    team[0]
  end

  def best_season(team_id_number)
    away = @games.data.group_by do |row|
      row[:away_team_id]
    end[team_id_number]
    away_by_season = if away.nil?
      []
    else
      away.group_by do |row|
        row[:season]
      end
    end
    away_wins_hash = Hash.new(0)
    away_by_season.each do |season, game_array|
      away_wins_hash[season] = {win: 0, total: 0}
      game_array.each do |game|
        if game[:away_goals] > game[:home_goals]
          away_wins_hash[season][:win] += 1
        end
        away_wins_hash[season][:total] += 1
      end
    end
    home = @games.data.group_by do |row|
      row[:home_team_id]
    end[team_id_number]
    home_by_season = if home.nil?
      []
    else
      home.group_by do |row|
        row[:season]
      end
    end
    home_wins_hash = Hash.new(0)
    home_by_season.each do |season, game_array|
      home_wins_hash[season] = {win: 0, total: 0}
      game_array.each do |game|
        if game[:home_goals] > game[:away_goals]
          home_wins_hash[season][:win] += 1
        end
        home_wins_hash[season][:total] += 1
      end
    end
    combined = Hash.new(0)
    away_wins_hash.each do |key, value|
      combined[key] = {win: 0, total: 0}
      combined[key][:win] = (home_wins_hash[key][:win] + value[:win])
      combined[key][:total] = (home_wins_hash[key][:total] + value[:total])
    end
    best_season = combined.max_by do |k, v|
      v[:win].to_f / v[:total].to_f
    end
    best_season[0]
  end

  def worst_season(team_id_number)
    away = @games.data.group_by do |row|
      row[:away_team_id]
    end[team_id_number]
    away_by_season = if away.nil?
      []
    else
      away.group_by do |row|
        row[:season]
      end
    end
    away_wins_hash = Hash.new(0)
    away_by_season.each do |season, game_array|
      away_wins_hash[season] = {win: 0, total: 0}
      game_array.each do |game|
        if game[:away_goals] > game[:home_goals]
          away_wins_hash[season][:win] += 1
        end
        away_wins_hash[season][:total] += 1
      end
    end
    home = @games.data.group_by do |row|
      row[:home_team_id]
    end[team_id_number]
    home_by_season = if home.nil?
      []
    else
      home.group_by do |row|
        row[:season]
      end
    end
    home_wins_hash = Hash.new(0)
    home_by_season.each do |season, game_array|
      home_wins_hash[season] = {win: 0, total: 0}
      game_array.each do |game|
        if game[:home_goals] > game[:away_goals]
          home_wins_hash[season][:win] += 1
        end
        home_wins_hash[season][:total] += 1
      end
    end
    combined = Hash.new(0)
    away_wins_hash.each do |key, value|
      combined[key] = {win: 0, total: 0}
      combined[key][:win] = (home_wins_hash[key][:win] + value[:win])
      combined[key][:total] = (home_wins_hash[key][:total] + value[:total])
    end
    worst_season = combined.min_by do |k, v|
      v[:win].to_f / v[:total].to_f
    end
    worst_season[0]
  end

  def average_win_percentage(team_id)
    team_win_total = Hash.new(0)
    team_win_total[team_id] = {win: 0, total: 0}
    @game_teams.data.each do |game|
      if game[:team_id] == team_id
        if game[:result] == "WIN"
          team_win_total[team_id][:win] += 1
        end
        team_win_total[team_id][:total] += 1
      end
    end
    (team_win_total[team_id][:win].to_f / team_win_total[team_id][:total].to_f).round(2)
  end

  def most_goals_scored(team_id)
    game_goals = []
    @game_teams.data.each do |game|
      if game[:team_id] == team_id
        game_goals << game[:goals]
      end
    end
    game_goals.max.to_i
  end

  def fewest_goals_scored(team_id)
    game_goals = []
    @game_teams.data.each do |game|
      if game[:team_id] == team_id
        game_goals << game[:goals]
      end
    end
    game_goals.min.to_i
  end

  def favorite_opponent(team_id)
    goals_by_teams = Hash.new(0)
    @teams.data.each do |team|
      goals_by_teams[team[:team_id]] = {win: 0, total: 0, name: team[:teamname]} if
      team[:team_id] != team_id
    end
    games_for_team_id = []
    @games.data.each do |game|
      if (game[:home_team_id] || game[:away_team_id]) == team_id
        games_for_team_id << game[:game_id]
      end
    end
    games_for_team_id.each do |expected|
      @game_teams.data.each do |game|
        if (game[:game_id] == expected) && (game[:team_id] != team_id)
          if game[:result] == "WIN"
            goals_by_teams[game[:team_id]][:win] += 1
          end
          goals_by_teams[game[:team_id]][:total] += 1
        end
      end
    end
    goals_by_teams.each do |team, hash|
      hash[:percentage] = if hash[:total] == 0
        1
      else
        (hash[:win].to_f / hash[:total].to_f)
      end
    end
    goals_by_teams.delete(nil)
    fav_opponent = goals_by_teams.min_by do |team, hash|
      hash[:percentage]
    end
    fav_opponent[1][:name]
  end

  def rival(team_id)
    goals_by_teams = Hash.new(0)
    @teams.data.each do |team|
      goals_by_teams[team[:team_id]] = {win: 0, total: 0, name: team[:teamname]} if
      team[:team_id] != team_id
    end
    games_for_team_id = []
    @games.data.each do |game|
      if (game[:home_team_id] || game[:away_team_id]) == team_id
        games_for_team_id << game[:game_id]
      end
    end
    games_for_team_id.each do |expected|
      @game_teams.data.each do |game|
        if (game[:game_id] == expected) && (game[:team_id] != team_id)
          if game[:result] == "WIN"
            goals_by_teams[game[:team_id]][:win] += 1
          end
          goals_by_teams[game[:team_id]][:total] += 1
        end
      end
    end
    goals_by_teams.each do |team, hash|
      hash[:percentage] = if hash[:total] == 0
        0
      else
        hash[:percentage] = (hash[:win].to_f / hash[:total].to_f)
      end
    end
    goals_by_teams.delete(nil)
    rival_opponent = goals_by_teams.max_by do |team, hash|
      hash[:percentage]
    end
    rival_opponent[1][:name]
  end
  # End Team Statistics methods

  # Start helpers
  def game_ids_by_season(season_id)
    game_id_array = []
    @games.season.each_with_index do |season, index|
      if season == season_id
        game_id_array << @games.game_id[index]
      end
    end
    game_id_array
  end
  # End helpers
end
