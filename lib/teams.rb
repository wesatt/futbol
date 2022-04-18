require "pry"
class Teams
  attr_reader :data # ,
  # :team_id,
  # :franchiseid,
  # :teamname,
  # :abbreviation,
  # :stadium,
  # :link

  def initialize(data)
    # @team_id = data[:team_id]
    # @franchiseid = data[:franchiseid]
    # @teamname = data[:teamname]
    # @abbreviation = data[:abbreviation]
    # @stadium = data[:stadium]
    # @link = data[:link]
    # @teams = {}

    @data = data

    # data.by_row!.each do |row|
    #   team_hash = row.to_h
    #   @teams[team_hash[:team_id].to_i] = team_hash
    # end
  end

  def team_id
    @data.map { |row| row[:team_id] }
  end

  def teamname
    @data.map { |row| row[:teamname] }
  end

  def by_id(id)
    @teams[id]
  end

  def hash_data
    @data.map do |d|
      d.to_hash
    end
  end
end
