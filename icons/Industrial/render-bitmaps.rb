#!/usr/bin/env ruby

require "rexml/document"
include REXML
INKSCAPE = '/usr/bin/inkscape'
SRC = "./svg"

puts "Rendering from SVGs in #{SRC}"
Dir.foreach(SRC) do |file|
  if file.match(/svg$/)
    svg = Document.new(File.new("#{SRC}/#{file}", 'r'))
    svg.root.each_element("//g[@inkscape:label='plate']/rect") do |icon|
      cmd = "#{INKSCAPE} -i #{icon.attributes['id']} -e #{icon.attributes['inkscape:label']} #{SRC}/#{file} > /dev/null 2>&1"
      system(cmd)
      print "."
    end
  end
end
puts "done rendering"
