#!/usr/bin/env ruby
#encoding:utf-8

require 'net/http'
require 'json'
require 'uri'

#RESULT
result = {}

FB_API_URL = 'http://api.facebook.com/'

complete_url = "#{FB_API_URL}method/links.getStats" + "?urls=#{ARGV[0]}&format=json"
response = Net::HTTP.get_response(URI.parse(complete_url))
response = JSON.parse(response.body)[0]

result[:like_count] = response['like_count']
result[:share_cont] = response['share_count']

#zatial bez argumentov
url = URI.parse(ARGV[0])
re = /^(?:(?>[a-z0-9-]*\.)+?|)([a-z0-9-]+\.(?>[a-z]*(?>\.[a-z]{2})?))$/i
domain = url.host.gsub(re, '\1').strip

FCB_GRAPH = 'http://graph.facebook.com/'

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
