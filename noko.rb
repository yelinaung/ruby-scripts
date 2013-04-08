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

#puts sources[:cb]
puts "Currencies from CB Bank are"
if @page = Nokogiri::HTML(open("AGD.html"))
    (1..3).each do |i|
        #puts @page.css("tr")[i].text.gsub(/\s+/,'')
    end
end

def to_hash
{
    rates: {
        USD: usd,
    }
}
end

def usd
    @page.css("tr")[1..3].text.gsub(/\s+|USD/,'')
end

def sgd
end

puts @doc= Nokogiri::HTML(open("AGD.html")).to_json
