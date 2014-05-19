class ReportsController < ApplicationController

	def index
      @empleados = Incident.find_by_sql("SELECT employee_id, name, mail FROM employees")
      @incidentsProd = Incident.find_by_sql("SELECT COUNT(*) as num_resueltos, name FROM incidents i, employees e WHERE i.encargado=e.employee_id AND estado = 'CERRADO' GROUP BY employee_id ORDER BY num_resueltos DESC")
      @tiempoProm = Incident.find_by_sql("SELECT AVG(DATEDIFF(fecha_final, fecha_inicio)) AS promedio, name 
FROM incidents i, employees e 
WHERE i.encargado=e.employee_id AND fecha_final IS NOT null 
GROUP BY employee_id")
      @menosProd = Incident.find_by_sql("SELECT name 
FROM employees 
WHERE employee_id NOT IN 
              (SELECT e_id 
               FROM attempts 
               WHERE DATEDIFF(NOW(), fecha_inicio) <= 7  
               GROUP BY e_id)")
	end

	def employee_productivity
      @empleados = Incident.find_by_sql("SELECT employee_id, name, mail FROM employees")
      @incidentsProd = Incident.find_by_sql("SELECT COUNT(*) as num_resueltos, name FROM incidents i, employees e WHERE i.encargado=e.employee_id AND estado = 'CERRADO' GROUP BY employee_id ORDER BY num_resueltos DESC")
      @tiempoProm = Incident.find_by_sql("SELECT AVG(DATEDIFF(fecha_final, fecha_inicio)) AS promedio, name 
FROM incidents i, employees e 
WHERE i.encargado=e.employee_id AND fecha_final IS NOT null 
GROUP BY employee_id")
      @menosProd = Incident.find_by_sql("SELECT name 
FROM employees 
WHERE employee_id NOT IN 
              (SELECT e_id 
               FROM attempts 
               WHERE DATEDIFF(NOW(), fecha_inicio) <= 7  
               GROUP BY e_id)")
	end

	def incidentes
      @areasMasIncidentes = Incident.find_by_sql("SELECT COUNT(*) as problemas_area, area FROM incidents i, catalogs c WHERE i.catalog=c.catalog_id GROUP BY area ORDER BY problemas_area DESC")
      @mesesConMasIncidentes = Incident.find_by_sql("SELECT COUNT(*) as incidentes_mes, MONTHNAME(fecha_inicio) AS mes FROM incidents GROUP BY mes ORDER BY incidentes_mes DESC")
      @diasConMasIncidentes = Incident.find_by_sql("SELECT COUNT(*) as incidentes_dia, DAYNAME(fecha_inicio) AS dia FROM incidents GROUP BY dia ORDER BY incidentes_dia DESC")
      @diasConMasResueltos = Incident.find_by_sql("SELECT COUNT(*) as incidentes_dia, DAYNAME(fecha_final) AS dia FROM incidents WHERE fecha_final IS NOT null GROUP BY dia ORDER BY incidentes_dia DESC")
      @areaMasDificil = Incident.find_by_sql("SELECT COUNT(*) as problemas_area, area FROM incidents i, catalogs c WHERE i.catalog=c.catalog_id and i.estado != 'CERRADO' GROUP BY area ORDER BY problemas_area DESC")
      @altaPrioridad = Incident.find_by_sql("SELECT descripcion FROM incidents WHERE estado = 'ABIERTO' AND prioridad = 'ALTA' ORDER BY fecha_inicio")
      @incidentesViejos = Incident.find_by_sql("SELECT descripcion, DATEDIFF(NOW(), fecha_inicio) AS dias FROM incidents WHERE estado = 'ABIERTO' ORDER BY dias DESC")
      @promPorAreas = Incident.find_by_sql("SELECT AVG(DATEDIFF(fecha_final, fecha_inicio)) AS promedio, area 
FROM incidents i, catalogs c 
WHERE i.catalog=c.catalog_id AND fecha_final IS NOT null 
GROUP BY area")
	end

	def usuarios
      @usuariosMasReportan = Incident.find_by_sql("SELECT COUNT(*) AS num_incidentes, name FROM incidents i, users u WHERE i.u_id=u.user_id GROUP BY user_id ORDER BY num_incidentes DESC LIMIT 0, 10")
      @usuarios = Incident.find_by_sql("SELECT name, mail 
FROM users")
      @noReportan = Incident.find_by_sql("SELECT name 
FROM users 
WHERE user_id NOT IN 
              (SELECT DISTINCT u_id 
               FROM incidents)")
	end
end
