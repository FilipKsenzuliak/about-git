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
