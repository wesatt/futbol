class GameTeams
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def shots
    @data.map { |row| row[:shots] }
  end

  def goals
    @data.map { |row| row[:goals] }
  end

  def team_id
    @data.map { |row| row[:team_id] }
  end

  def game_id
    @data.map { |row| row[:game_id] }
  end

  def head_coach
    @data.map { |row| row[:head_coach] }
  end

  def hash_data
    @data.map do |d|
      d.to_hash
    end
  end
end
