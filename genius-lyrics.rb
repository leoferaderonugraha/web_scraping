#!/usr/bin/ruby

require 'nokogiri'
require 'mechanize'

if ARGV.empty?
    puts "Usage #{__FILE__} \"Artist - Songs Title\""
    exit
end

uri = "https://www.bing.com/search?q=#{ARGV.join('+')}+site:genius.com"
links = []
data = []
mech = Mechanize.new
mech.redirect_ok = true
mech.user_agent = 'Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20100101 Firefox/7.0.1'

mech.get(uri)
doc = Nokogiri::HTML(mech.page.body)
doc.css('li.b_algo a').each{|link| links.append(link['href'])} #extract all links
mech.get(links[0])  #open the first link
doc = Nokogiri::HTML(mech.page.body) #parse
doc.css('p').each {|x| data << x.content} #extract data between elements

puts data[0]
