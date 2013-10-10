#!/usr/bin/env ruby
#encoding:utf-8

require 'net/http'
require 'uri'
require 'json'

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

