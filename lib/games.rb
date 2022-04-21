
class Games
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def game_id
    @data.map { |row| row[:game_id] }
  end

  def season
    @data.map { |row| row[:season] }
  end

  def away_goals
    @data.map { |row| row[:away_goals] }
  end

  def home_goals
    @data.map { |row| row[:home_goals] }
  end

  def away_team_id
    @data.map { |row| row[:away_team_id] }
  end

  def home_team_id
    @data.map { |row| row[:home_team_id] }
  end

  def total_scores
    away_goals.each_with_index.map do |score, index|
      score.to_i + home_goals[index].to_i
    end
  end

  def game_outcomes
    outcomes = Hash.new(0)
    away_goals.each_with_index do |score, index|
      if score.to_i > home_goals[index].to_i
        outcomes[:away_win] += 1
        outcomes[:total] += 1
      elsif score.to_i < home_goals[index].to_i
        outcomes[:home_win] += 1
        outcomes[:total] += 1
      elsif score.to_i == home_goals[index].to_i
        outcomes[:tie] += 1
        outcomes[:total] += 1
      else
        raise "error with game_outcomes"
      end
    end
    outcomes
  end

  def games_by_season_hash
    games_by_season = {count: Hash.new(0), average_goals: Hash.new(0)}
    total_goals_by_season = Hash.new(0)
    season.each_with_index do |season_1, index|
      games_by_season[:count][season_1] += 1
      total_goals_by_season[season_1] += (home_goals[index].to_i + away_goals[index].to_i)
    end
    games_by_season[:count].each do |season1, season_count|
      total_goals_by_season.each do |season2, total_score|
        games_by_season[:average_goals][season2] = (total_score.to_f / season_count.to_f).round(2) if
        season1 == season2
      end
    end
    games_by_season
  end
end
