# DWG to SVG Batch Converter
def list_file(x)
    Dir.glob("#{x}*.dwg") do |dwg_file|
        next if dwg_file == '.' or dwg_file == '..'
        puts dwg_file
    #    return dwg_file
    end
end
list_file(ARGV[0].to_s)
