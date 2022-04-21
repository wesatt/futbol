require_relative './stat_tracker'

module GameTeamsMod

  def fewest_goals_scored(team_id)
    game_goals = []
    @game_teams.data.each do |game|
      if game[:team_id] == team_id
        game_goals << game[:goals]
      end
    end
    game_goals.min.to_i
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
end
