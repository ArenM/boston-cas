class CopyExistingMatchRoutesIntoClientOpportunityMatches < ActiveRecord::Migration[4.2]
  def up
    ClientOpportunityMatch.find_each do |match|
      next unless match.program && match.program.match_route
      match.update!(match_route_id: match.program.match_route.id)
    end
  end
end
