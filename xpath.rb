require 'open-uri'
require 'nokogiri'
doc = Nokogiri.HTML(open('http://www.highcharts.com/demo/'))
    inline_script = doc.xpath('//script[not(@src)]')
    inline_script.each do |script|
    puts "-"*50, script.text
end
