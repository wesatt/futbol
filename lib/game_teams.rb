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
  end

  def game_id
    @data.map { |row| row[:game_id] }
  end
end
