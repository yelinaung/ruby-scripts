require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'json'

page_url = "http://www.cbbankmm.com/fxratesho.php"
sources = {
    cb: "http://www.cbbankmm.com/fxratesho.php",
    agd: "http://www.agdbank.com/",
    central: "http://forex.cbm.gov.mm/api/latest"
}

puts sources[:cb]
puts "Currencies from CB Bank are"
if @page = Nokogiri::HTML(open(sources[:cb]))
    (1..3).each do |i|
        puts @page.css("tr")[i].text.gsub(/\s+/,'')
    end
end
#puts "Currencies from AGD Bank are"
if @page = Nokogiri::HTML(open("CB.html"))
    (1..3).each do |x|
        #puts @page.css("tr")[x].text
    end
end
