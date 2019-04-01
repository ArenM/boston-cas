class Rules::OneYearHomelessLastThreeYears < Rule
  def clients_that_fit(scope, requirement)
    c_t = Client.arel_table
    if Client.column_names.include?(:days_homeless_in_last_three_years.to_s)
      if requirement.positive
        where = c_t[:days_homeless_in_last_three_years].gteq(365)
      else
        where = c_t[:days_homeless_in_last_three_years].lt(365)
      end
      scope.where(where)
    else
      raise RuleDatabaseStructureMissing, "clients.days_homeless_in_last_three_years missing. Cannot check clients against #{self.class}."
    end
  end
end
