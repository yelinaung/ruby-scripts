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

    def parsed_CB
        @parsed_CB ||= @page.css("tr")[1..4].collect{|el| el.text.gsub(/\s+/,'')}
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
            FEC: cb_fec,
            SGD: cb_sgd,
            EURO: euro,
        }
    }
    end

    def usd
       parsed[0].gsub(/[^0-9]|s+/,'').to_s.scan(/.../).map { |h| h.to_i}.to_s
    end

    def cb_fec
        parsed_CB[1].gsub(/FEC|^[0-9]|s+/,'').chars.each_slice(2).map {|h| h.join.to_i}.to_s
    end

    def sgd
       parsed[0].gsub(/[^0-9]|s+/,'').to_s.scan(/.../).map { |h| h.to_i}.to_s
    end

    def cb_sgd
        parsed_CB[2].gsub(/[^0-9]|s+/,'').to_s.scan(/.../).map {|h| h.to_i}.to_s
    end

    def euro
        parsed_CB[if @bank=="AGD"
        2
        elsif @bank=="CB"
        3
        else
        end].gsub(/[^0-9]|s+/,'').to_s.scan(/..../).map { |h| h.to_i}.to_s
    end

    def cb_euro
        parased[3].gsub(/[^0-9]|s+/,'').to_s.scan(/..../).map {|h| h.to_i}.to_s
    end
end

puts Currencies.new(Nokogiri::HTML(open(sources[:agd])),"AGD").to_hash_AGD.to_json
puts Currencies.new(Nokogiri::HTML(open(sources[:cb])),"CB").to_hash_CB.to_json
