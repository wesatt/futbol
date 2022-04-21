require_relative "./stat_tracker"

module TeamsMod
  def team_info(team_id)
    teams_by_group = @teams.data.group_by do |team|
      team[:team_id]
    end
    team = teams_by_group[team_id]
    team[0].delete(:stadium)
    team[0]["team_id"] = team[0].delete(:team_id)
    team[0]["franchise_id"] = team[0].delete(:franchiseid)
    team[0]["team_name"] = team[0].delete(:teamname)
    team[0]["abbreviation"] = team[0].delete(:abbreviation)
    team[0]["link"] = team[0].delete(:link)
    team[0]
  end

  def count_of_teams
    @teams.data.length
  end

  def favorite_opponent(team_id)
    goals_by_teams = Hash.new(0)
    @teams.data.each do |team|
      goals_by_teams[team[:team_id]] = {win: 0, total: 0, name: team[:teamname]} if
      team[:team_id] != team_id
    end
    games_for_team_id = []
    @games.data.each do |game|
      if (game[:home_team_id] || game[:away_team_id]) == team_id
        games_for_team_id << game[:game_id]
      end
    end
    games_for_team_id.each do |expected|
      @game_teams.data.each do |game|
        if (game[:game_id] == expected) && (game[:team_id] != team_id)
          if game[:result] == "WIN"
            goals_by_teams[game[:team_id]][:win] += 1
          end
          goals_by_teams[game[:team_id]][:total] += 1
        end
      end
    end
    goals_by_teams.each do |team, hash|
      hash[:percentage] = if hash[:total] == 0
        1
      else
        (hash[:win].to_f / hash[:total].to_f)
      end
    end
    goals_by_teams.delete(nil)
    fav_opponent = goals_by_teams.min_by do |team, hash|
      hash[:percentage]
    end
    fav_opponent[1][:name]
  end

  def rival(team_id)
    goals_by_teams = Hash.new(0)
    @teams.data.each do |team|
      goals_by_teams[team[:team_id]] = {win: 0, total: 0, name: team[:teamname]} if
      team[:team_id] != team_id
    end
    games_for_team_id = []
    @games.data.each do |game|
      if (game[:home_team_id] || game[:away_team_id]) == team_id
        games_for_team_id << game[:game_id]
      end
    end
    games_for_team_id.each do |expected|
      @game_teams.data.each do |game|
        if (game[:game_id] == expected) && (game[:team_id] != team_id)
          if game[:result] == "WIN"
            goals_by_teams[game[:team_id]][:win] += 1
          end
          goals_by_teams[game[:team_id]][:total] += 1
        end
      end
    end
    goals_by_teams.each do |team, hash|
      hash[:percentage] = if hash[:total] == 0
        0
      else
        hash[:percentage] = (hash[:win].to_f / hash[:total].to_f)
      end
    end
    goals_by_teams.delete(nil)
    rival_opponent = goals_by_teams.max_by do |team, hash|
      hash[:percentage]
    end
    rival_opponent[1][:name]
  end
end
