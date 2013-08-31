module ApplicationHelper
  
  def table_color(event_site)
  	case event_site
  	when "ATND"
  	  "error"
  	when "Partake"
  	  "info"
  	when "DoorKeeper"
  	  "success"
  	else
  	  "default"
	end	
  end

end
