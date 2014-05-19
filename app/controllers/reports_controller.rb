class ReportsController < ApplicationController

	def index
		
	end

	def employee_productivity
      @incidents = Incident.find_by_sql("SELECT COUNT(*) as num_resueltos, name FROM incidents i, employees e WHERE i.encargado=e.employee_id GROUP BY name ORDER BY num_resueltos DESC")
	end

end
