require 'pry'
require "csv"
require_relative "./game_teams"
require_relative "./games"
require_relative "./teams"

class StatTracker
  attr_reader :teams, :game_teams, :games

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

  def winningest_coach(season_arg)
    coach_by_season = Hash.new(0)
    team_id_for_season = Hash.new(0)
    @teams.team_id.each do |team|
      team_id_for_season[team] = {win: 0, total: 0}
    end

    # adds wins and totals
    @games.season.each_with_index do |season, index|
      if season == season_arg
        if @games.away_goals[index].to_i > @games.home_goals[index].to_i
          team_id_for_season[@games.away_team_id[index]][:win] += 1
        elsif @games.away_goals[index].to_i < @games.home_goals[index].to_i
          team_id_for_season[@games.home_team_id[index]][:win] += 1
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

    # makes hash of coaches and wins
    team_id_for_season.each do |key_id, value_hash|
      percentage = (value_hash[:win].to_f / value_hash[:total].to_f).round(2)
      coach_by_season[value_hash[:coach]] = if percentage > 0
        percentage
      else
        0
      end
    end

    best_coach = coach_by_season.max_by { |k, v| v }
    best_coach[0]
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
  # Start Season Statistics methods



  # End Season Statistics methods
end
