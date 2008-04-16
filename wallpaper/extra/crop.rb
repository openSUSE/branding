#!/usr/bin/env ruby
#convert -gravity Center -crop 1600x1200+0+0 +repage
IN = '16to10'
OUT = '4to3'

dir = Dir.open(IN)
dir.each do |file|
  if (file.match(/\.png$/))
    puts file
    system "convert -gravity Center -crop 1600x1200+0+0 +repage #{IN}/#{file} #{OUT}/#{file}"
  end
end
