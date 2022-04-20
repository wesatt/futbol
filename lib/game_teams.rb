require "pry"

class GameTeams
  attr_reader :data # ,
  # :game_id,
  # :team_id,
  # :hoa,
  # :result,
  # :settled_in,
  # :head_coach,
  # :goals,
  # :shots,
  # :tackles,
  # :pim,
  # :powerplayopportunities,
  # :powerplaygoals,
  # :faceoffwinpercentage,
  # :giveaways,
  # :takeaways

  def initialize(data)
    # @game_id = data[:game_id]
    # @team_id = data[:team_id]
    # @hoa = data[:hoa]
    # @result = data[:result]
    # @settled_in = data[:settled_in]
    # @head_coach = data[:head_coach]
    # @goals = data[:goals]
    # @shots = data[:shots]
    # @tackles = data[:tackles]
    # @pim = data[:pim]
    # @powerplayopportunities = data[:powerplayopportunities]
    # @powerplaygoals = data[:powerplaygoals]
    # @faceoffwinpercentage = data[:faceoffwinpercentage]
    # @giveaways = data[:giveaways]
    # @takeaways = data[:takeaways]
    @data = data
    @game_teams_rows = {}

  end

  def game_id
    @data.map { |row| row[:game_id] }
  end

  def head_coach
    @data.map { |row| row[:head_coach] }
  end

  def gt_by_id(id)
    @game_teams_rows[id]
  end

  def hash_data
    @data.map do |d|
      d.to_hash
    end
  end


end
