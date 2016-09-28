require "hamfinder/version"

module Hamfinder
	class Parser
		def self.query(options = {})
			band = band_selection(options[:band])
			options[:radius] ? radius = set_radius(options[:radius]) : radius = "&distance=10&Dunit=m"
			zip = set_zip(options[:zip])
			url = "https://www.repeaterbook.com/repeaters/prox_result.php?#{zip}#{radius}#{band}&status_id=1"
			parse(url)
		end

		private

		def self.parse(url)
			# Captures the queried URL from Repeaterbook.com
			doc = Nokogiri::HTML(open(url))

			# This scrapes dirty data from HTML table -
			# the source is improperly drawn without opening <tr> tags
			# so we collect all of the orphaned <td> children of <table>
		  all_tds = doc.xpath('//table/td').map {|content| content.text }
		  
		  if all_tds.empty?
		  	# Capturing error messages from the source
		  	# if no results are found
				error_message = {}
				error = doc.xpath('//center/b').map {|content| content.text }	
				error_message[:error] = "#{error}"
			else
		  	tidy_tds = sanitize(all_tds)
		  	repeater_array = organize(tidy_tds)
		  	repeater_array.sort! {|x,y| x[8].to_f <=> y[8].to_f }
		  	generate_JSON(repeater_array)
			end
		end

		# returns band parameter for URL
		def self.band_selection(band)
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

		# returns only valid user-defined radius OR 25mi for radius parameter for URL
		def self.set_radius(radius)
			if radius > 0 && radius <= 200
				return "&distance=#{radius}&Dunit=m"
			else
				return "&distance=10&Dunit=m"
			end
		end

		# returns city parameter for URL
		def self.set_zip(zip)
			return "city=#{zip}"
		end

		# Sanitizes non-breaking space characters,
		# linebreaks, and spaces throughout table data
		# introduced by source
		def self.sanitize(collection)
		  collection.each do |td|
		    td.gsub!("\u00A0", "")
		    td.gsub!("\n", "")
		    td.delete!(" ")
		  end
		end

		# Organizes the data from the orphaned <td>s 
		# by row into an array
		def self.organize(collection)
			data = []
		    until collection.empty?
		      row = collection.shift(11)
		      row.pop
		      data << row
		    end
		  data
		end

		# Parse to JSON FORMAT and return
		def self.generate_JSON(data)
			output = {}
			index = 0
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
				output[index.to_s.to_sym] = r
				index +=1
				end
			output.to_json
		end

	end #parser
end #module