
class Teams
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def team_name_by_id(id)
    @data.find do |hash|
      return hash[:teamname] if hash[:team_id] == id
    end
  end

  def team_id
    @data.map { |row| row[:team_id] }
  end

  def teamname
    @data.map { |row| row[:teamname] }
  end
end
