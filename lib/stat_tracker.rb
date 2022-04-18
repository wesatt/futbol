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
    games_grouped_by_season = @game_teams.data.group_by do |game|
      game[:game_id]
    end

    list_of_games_by_season = []
    game_ids_by_season(season_arg).each do |game_id|
      list_of_games_by_season << games_grouped_by_season[game_id]
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
end
