#!/usr/bin/env ruby

require "rexml/document"
require "ftools"
include REXML
INKSCAPE = '/usr/bin/inkscape'
SRC = "./svg"

def renderit(file)
  svg = Document.new(File.new("#{SRC}/#{file}", 'r'))
  context = svg.root.elements['//dc:description'].text
  svg.root.each_element("//g[@inkscape:label='plate']/rect") do |icon|
    dir = "#{icon.attributes['width']}x#{icon.attributes['height']}/#{context}"
    cmd = "#{INKSCAPE} -i #{icon.attributes['id']} -e #{dir}/#{file.gsub(/\.svg$/,'.png')} #{SRC}/#{file} > /dev/null 2>&1"
    File.makedirs(dir) unless File.exists?(dir)
    system(cmd)
    print "."
    #puts cmd
  end
end

if (ARGV[0].nil?) #render all SVGs
  puts "Rendering from SVGs in #{SRC}"
  Dir.foreach(SRC) do |file|
    renderit(file) if file.match(/svg$/)
  end
  puts "\nrendered all SVGs"
else #only render the SVG passed
  file = "#{ARGV[0]}.svg"
  if (File.exists?("#{SRC}/#{file}"))
    renderit(file)
    puts "\nrendered #{file}"
  else
    puts "[E] No such file (#{file})"
  end
end
