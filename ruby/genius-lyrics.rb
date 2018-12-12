#!/usr/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'mechanize'

if ARGV.empty?
  puts "Usage #{__FILE__} \"artis - songs title\""
  exit
end

uri = "https://www.bing.com/search?q=#{ARGV.join('+')}+site:genius.com"
links = []
mech = Mechanize.new
mech.redirect_ok = true
mech.user_agent = 'Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20100101 Firefox/7.0.1'

mech.get(uri)
doc = Nokogiri::HTML(mech.page.body)
doc.css('li.b_algo a').map{|link| links.append(link['href'])}

doc = Nokogiri::HTML(open(links[0]).read)
doc.css('p').each {|data| puts data.text}
