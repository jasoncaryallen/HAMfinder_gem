require "hamfinder/version"

module Hamfinder
	class Parser
		def query(options = {})
			band = band_selection(options[:band])
			radius = set_radius(options[:radius])
			zip = options[:zip]
			url = "https://www.repeaterbook.com/repeaters/prox_result.php?city=#{zip}&distance=#{radius}&Dunit=m#{band}&status_id=1&use=OPEN"
		# binding.pry
			parse(url)
		end

		private

		def parse(url)
			#queries data from Repeaterbook.com
			doc = Nokogiri::HTML(open(url))

			# scrapes dirty data <td> tags from HTML table
			# source is improperly drawn without opening <tr> tags
		  all_tds = doc.xpath('//table/td').map {|content| content.text }
		  
		  if all_tds.empty?
				error = doc.xpath('//center/b').map {|content| content.text }	
				error.to_json
			else
			  # Sanitizes non-breaking space characters, linebreaks, and spaces throughout table data
			  	tidy_tds = sanitize(all_tds)
			  # Organizes the data by row into an array
			  	repeater_array = organize(tidy_tds)
			  # Parse to JSON FORMAT and return
			  	generate_JSON(repeater_array)
			end
		end

		def generate_JSON(data)
			output = {}
				data.each do |repeater|
		     r = {frequency: "#{repeater[0]}",
				      offset:    "#{repeater[1]}",
				      tone:      "#{repeater[2]}",
				      call:      "#{repeater[3]}",
				      location:  "#{repeater[4]}",
				      state:     "#{repeater[5]}",
				      usage:     "#{repeater[6]}",
				      voip:      "#{repeater[7]}",
				      distance:  "#{repeater[8]}",
				      direction: "#{repeater[9]}"}
				output[repeater[3].to_sym] = r
				end
			output
		end

		def sanitize(collection)
		  collection.each do |td|
		    td.gsub!("\u00A0", "")
		    td.gsub!("\n", "")
		    td.delete!(" ")
		  end
		end

		def organize(collection)
			data = []
		    until collection.empty?
		      row = collection.shift(11)
		      row.pop
		      data << row
		    end
		  data
		end

		def set_radius(radius)
			if radius > 0 && radius <= 200
				return radius
			else
				return 25
			end
		end

		def band_selection(band)
			case band
				when "10m"   
					return "&band=29"
				when "6m"    
					return "&band=5"
				when "2m"    
					return "&band=14"
				when "1.25m" 
					return "&band=22"
				when "70cm"  
					return "&band=4"
				when "33cm"  
					return "&band=9"
				when "23cm"  
					return "&band=12"
				else
					return "&band=14"
			end			
		end

	end #parser

end #module
