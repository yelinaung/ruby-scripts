require 'nokogiri'
require 'json'
require 'open-uri'
require 'net/http'

sources = {
    cb: "http://www.cbbankmm.com/FXRatesHo.php",
    kbz: "http://www.kbzbank.com/",
    agd: "http://www.agdbank.com/category/exchange-rate/",
    central: "http://forex.cbm.gov.mm/api/latest"
}
class Currencies
    @bank
    def initialize (page, bank)
        @page = page
        @bank = bank
    end

    def parsed
        @parsed ||= @page.css("tr")[1..3].collect{|el| el.text.gsub(/\s+/,'') }
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
       parsed[0].gsub(/[^0-9]|s+/,'').to_s.scan(/.../).map { |h| h.to_i}.to_s
    end

    #def fec
    #    parsed[1].gsub(/FEC|^[0-9]|s+/,'')
    #end

    def sgd
        parsed[1].gsub(/[^0-9]|s+/,'').to_s.scan(/.../).map { |h| h.to_i}.to_s
    end

    def euro
        parsed[2].gsub(/[^0-9]|s+/,'').to_s.scan(/..../).map { |h| h.to_i}.to_s
    end
end

puts Currencies.new(Nokogiri::HTML(open("AGD.html")),"AGD").to_hash_AGD.to_json
#puts Currencies.new(Nokogiri::HTML(open("CB.html")),"CB").to_hash_CB.to_json
