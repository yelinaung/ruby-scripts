class Currencies

    def initialize(page, bank)
        @page = page
        @bank = bank
    end

    def parsed
        @parsed ||= @page.css("tr")[i].text.gsub(/\s+/,'')
    end

    def to_hash
    {
        bank: @bank,
        rates: {
            USD: usd,
            SGD: sgd,
        }
    }
    end

    def usd
        @parsed[0].gsub(/^USD/, '')
    end

    def sgd
        @parsed[1].gsub(/^SGD/, '')
    end
end
