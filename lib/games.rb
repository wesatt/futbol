class Games
  attr_reader :data # ,
  # :game_id,
  # :season,
  # :type,
  # :date_time,
  # :away_team_id,
  # :home_team_id,
  # :away_goals,
  # :home_goals,
  # :venue,
  # :venue_link

  def initialize(data)
    # @game_id = data[:game_id]
    # @season = data[:season]
    # @type = data[:type]
    # @date_time = data[:date_time]
    # @away_team_id = data[:away_team_id]
    # @home_team_id = data[:home_team_id]
    # @away_goals = data[:away_goals]
    # @home_goals = data[:home_goals]
    # @venue = data[:venue]
    # @venue_link = data[:venue_link]
    @data = data

    # @by_game_home = Hash.new
    # data.by_row!.each do |row|
    #   game_home_hash = row.to_h
    #   @by_game_home[game_home_hash[:home_team_id]] = game_home_hash
    # end
    # @by_game_away = Hash.new
    # data.by_row!.each do |row|
    #   game_away_hash = row.to_h
    #   @by_game_away[game_away_hash[:away_team_id]] = game_away_hash
    # end
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
      total_goals_by_season[season_1] += (@data[:home_goals][index].to_i + @data[:away_goals][index].to_i)
    end
    games_by_season[:count].each do |season1, season_count|
      total_goals_by_season.each do |season2, total_score|
        games_by_season[:average_goals][season2] = (total_score.to_f / season_count.to_f).round(2) if
        season1 == season2
      end
    end
    games_by_season
  end

  #   def season_win_by_team
  #     @by_teams.each do |team|
  # binding.pry
  #     end
  #   end

  # def self.create_list_of_game(games)
  #   games.map { |games| Games.new(games) }
  # end

  def hash_data
    @data.map do |d|
      d.to_hash
    end
  end
end
