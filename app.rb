#!/usr/bin/env ruby
#encoding:utf-8

require 'net/http'
require 'json'
require 'uri'

FB_API_URL = 'http://api.facebook.com/'

complete_url = "#{FB_API_URL}method/links.getStats" + "?urls=#{ARGV[0]}&format=json"
response = Net::HTTP.get_response(URI.parse(complete_url))
response = JSON.parse(response.body)[0]

puts "Likes count: #{response['like_count']}"
puts "Share count: #{response['share_count']}"

#zatial bez argumentov
url = URI.parse('http://zpravy.idnes.cz/odposlechy-pancove-v-kauze-kolem-ratha-dyk-/domaci.aspx?c=A131009_220818_domaci_zt')
re = /^(?:(?>[a-z0-9-]*\.)+?|)([a-z0-9-]+\.(?>[a-z]*(?>\.[a-z]{2})?))$/i
domain = url.host.gsub(re, '\1').strip

FCB_GRAPH = 'http://graph.facebook.com/'

#RESULT
result = {}

response = Net::HTTP.get_response(URI.parse("#{FCB_GRAPH}#{domain}"))
pr = JSON.parse(response.body)

if pr['error']
	puts "PAGE NOT FOUND"
	exit
end

result[:host] = domain
result[:fb_id] = pr['id'] 
result[:host_like_count] = pr['likes']

puts result
