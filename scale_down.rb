factor = 100.0
File.open(ARGV[0]).readlines.each do |line|
	if line.strip.index("<path") == 0
		m = line.index("M")
		n = line.index("\"",m)
		orgv = line[m..n]
		pairs = orgv.split(" ")[1..-1]
		pp = pairs.collect do |p|
			v = p
			unless p.index(",").nil?
				x,y = p.split(",")
				v = [x.to_f/factor,y.to_f/factor].join(",").to_s
			end
			v
		end
		ll = line.gsub(orgv,"M #{pp.join(" ")}\"")
        # Replacing stroke width with 1px 
		puts ll.gsub("0.100000","1").gsub("0.1px","1px")

    # Scaling Down the SVG width and height
	elsif line.strip.index("width") == 0
		val = line.split("=")[1][1..-2]
		puts "width=\"#{(val.to_f/factor)}\""
	elsif line.strip.index("height") == 0
		val = line.split("=")[1][1..-2]
		puts "height=\"#{(val.to_f/factor)}\""
	else
		puts line
	end
end
