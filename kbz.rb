require 'Nokogiri'
require 'json'

@doc = Nokogiri::HTML(open("KBZ.html"))

puts @doc.css("td")[0].text.gsub(/\n/,',')
puts @doc.css("tr").text

def to_hash
{
    bank: "KBZ",
    rates: {
        USD:usd,
        SGD:sgd,
        EURO:euro,
        FEC:fec,
    }
}
end
