require 'nokogiri'
require 'json'
require 'open-uri'
require 'net/http'

# Bank Sources
sources = {
    cb: "http://www.cbbankmm.com/FXRatesHo.php",
    kbz: "http://www.kbzbank.com/",
    agd: "http://www.agdbank.com/category/exchange-rate/",
    central: "http://forex.cbm.gov.mm/api/latest"
}

class KBZ
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

  def to_hash_KBZ
  {
      bank: "KBZ",
      rates: {
          USD:KBZ.kbz_usd,
          SGD:KBZ.kbz_sgd,
          EURO:KBZ.kbz_euro,
          FEC:KBZ.kbz_fec
      }
  }
  end

  def KBZ.kbz_usd
      "[#{@usd_b},#{@usd_s}]"
  end

  def KBZ.kbz_sgd
      "[#{@sgd_b},#{@sgd_s}]"
  end

  def KBZ.kbz_euro
      "[#{@euro_b},#{@euro_b}]"
  end

  def KBZ.kbz_fec
      "[#{@fec_b},#{@fec_s}]"
  end
end

class Currencies
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

    # To hash method for AGD
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

    # To hash method for CB
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
        parsed[0].gsub(/\D/,'').to_s.scan(/.../).map { |h| h.to_i}.to_s
    end

    def cb_fec
        parsed_CB[1].gsub(/\D/,'').to_i.divmod(10).to_s
    end

    def sgd
        parsed[1].gsub(/[^0-9]|s+/,'').to_s.scan(/.../).map { |h| h.to_i}.to_s
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

    def kbz_euro
        parsed_CB[2].gsub(/\D/,'').to_s.scan(/..../).map{|h| h.to_i}.to_s
    end

    def kbz_fec
        parsed_CB[3].gsub(/\D/,'').to_s.scan(/.../).map {|h| h.to_i}.to_s
    end
end

puts JSON.pretty_generate(Currencies.new(Nokogiri::HTML(open(sources[:agd])),"AGD").to_hash_AGD)
puts JSON.pretty_generate(Currencies.new(Nokogiri::HTML(open(sources[:cb])),"CB").to_hash_CB)
puts JSON.pretty_generate(KBZ.new.to_hash_KBZ)
