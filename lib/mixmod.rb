require_relative './stat_tracker'

module MixMod

  def best_offense
    game_teams = @game_teams.data
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
    game_teams = @game_teams.data
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
    game_teams = @game_teams.data
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
    game_teams = @game_teams.data
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
    game_teams = @game_teams.data
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
    game_teams = @game_teams.data
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

end
