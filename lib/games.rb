class Games
  attr_reader :game_id,
    :season,
    :type,
    :date_time,
    :away_team_id,
    :home_team_id,
    :away_goals,
    :home_goals,
    :venue,
    :venue_link

  def initialize(data)
    @game_id = data[:game_id]
    @season = data[:season]
    @type = data[:type]
    @date_time = data[:date_time]
    @away_team_id = data[:away_team_id]
    @home_team_id = data[:home_team_id]
    @away_goals = data[:away_goals]
    @home_goals = data[:home_goals]
    @venue = data[:venue]
    @venue_link = data[:venue_link]
  end

  def total_scores
    @away_goals.each_with_index.map do |score, index|
      score.to_i + @home_goals[index].to_i
    end
  end

  def game_outcomes
    outcomes = {away_win: 0, home_win: 0, tie: 0, total: 0}
    @away_goals.each_with_index do |score, index|
      if score.to_i > @home_goals[index].to_i
        outcomes[:away_win] += 1
        outcomes[:total] += 1
      elsif score.to_i < @home_goals[index].to_i
        outcomes[:home_win] += 1
        outcomes[:total] += 1
      elsif score.to_i == @home_goals[index].to_i
        outcomes[:tie] += 1
        outcomes[:total] += 1
      else
        raise "error with game_outcomes"
      end
    end
    outcomes
  end
end
