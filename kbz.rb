require 'Nokogiri'
require 'json'

@doc = Nokogiri::HTML(open("KBZ.html"))

# Selecting the first col
x = @doc.css("tr")[1].text.gsub(/\n/,' ')
# Splitting the string into array
buy = x.chomp.split(/\s+/)
@usd_b = buy[1]
@sgd_b = buy[2]
@euro_b = buy[3]
@fec_b = buy[4]

# Selecting the second col
y = @doc.css("tr")[2].text.gsub(/\n/,' ')
# Splitting array into array
sell = y.chomp.split(/\s+/)
@usd_s = sell[1]
@sgd_s = sell[2]
@euro_s = sell[3]
@fec_s = sell[4]

def to_hash
{
    bank: "KBZ",
    rates: {
        USD:usd,
        SGD:sgd,
        EURO:euro,
        FEC:fec
    }
}
end

def usd
    "[#{@usd_b},#{@usd_s}]"
end

def sgd
    "[#{@sgd_b},#{@sgd_s}]"
end

def euro
    "[#{@euro_b},#{@euro_b}]"
end

def fec
    "[#{@fec_b},#{@fec_s}]"
end

puts JSON.pretty_generate(to_hash)
