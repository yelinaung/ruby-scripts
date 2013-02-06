# DWG to SVG Batch Converter
def list_file(x)
    # Listing Files
    # Dir.foreach(x) do |item|
    #   next if item == '.' or item == '..'
    #   puts item
    # end
    Dir.glob("#{x}*.dwg") do |dwg_file|
        next if item == '.' or item == '..'
        puts dwg_file
    end
end

list_file(ARGV[0].to_s)
