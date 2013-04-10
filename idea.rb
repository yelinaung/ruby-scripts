require 'nokogiri'
require 'json'

class Currencies
    @bank
    def initialize (page, bank)
        @page = page
        @bank = bank
    end

    def parsed
        @parsed ||= @page.css("tr")[1..5].collect{|el| el.text.gsub(/\s+/,'') }
    end

    def to_hash_AGD
    {
        bank: @bank,
        rates: {
            USD: usd,
            SGD: sgd,
            EURO: euro,
        }
    }
    end

    def to_hash_CB
    {
        bank: @bank,
        rates: {
            USD: usd,
            FEC: fec,
            SGD: sgd,
            EURO: euro,
        }
    }
    end

    def usd
        parsed[0].gsub(/[^0-9]|s+/, '')
    end

    def fec
        parsed[1].gsub(/FEC|^[0-9]|s+/,'')
    end

    def sgd
        parsed[2].gsub(/[^0-9]|s+/, '')
    end

    def euro
        parsed[3].gsub(/[^0-9]|s+/, '')
    end
end

puts Currencies.new(Nokogiri::HTML(open("AGD.html")),"AGD").to_hash_AGD.to_json
puts Currencies.new(Nokogiri::HTML(open("CB.html")),"CB").to_hash_CB.to_json
