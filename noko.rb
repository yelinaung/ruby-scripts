require 'net/http'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

PAGE_URL = "http://www.cbbankmm.com/FXRatesHo.php"
sources = {
    cb: "http://www.cbbankmm.com/FXRatesHo.php",
    agd: "http://www.agdbank.com/",
    central: "http://forex.cbm.gov.mm/api/latest"
}

puts "Currencies from CB Bank are"
if @page = Nokogiri::HTML(open("AGD.html"))
    (1..3).each do |i|
        @page.css("tr")[i].text
    end
end
puts $z
#puts "Currencies from AGD Bank are"
if @page = Nokogiri::HTML(open("CB.html"))
    (1..3).each do |x|
        #puts @page.css("tr")[x].text
    end
end
