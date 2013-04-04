# DWG to SVG Batch Converter
def list_file(x)
    Dir.glob("#{x}*.dwg") do |dwg_file|
        next if dwg_file == '.' or dwg_file == '..'
        @dwg = dwg_file
        #dir = "#{Dir.home}/libredwg/examples/dwg2svg"
        #y = system("sh #{dir}")
    end
end
puts "#{@dwg}"
list_file(ARGV[0].to_s)
