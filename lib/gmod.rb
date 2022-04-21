require_relative './stat_tracker'

module GamesMod

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

  def game_ids_by_season(season_id)
    game_id_array = []
    @games.season.each_with_index do |season, index|
      if season == season_id
        game_id_array << @games.game_id[index]
      end
    end
    game_id_array
  end
end
