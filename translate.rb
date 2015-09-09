# terminal translator 1.0 (en <-> chs)
# 命令行中英翻译脚本
# by ceil 20150905

require 'net/http'
require 'uri'
require 'json'

# KEY申请:  http://fanyi.youdao.com/openapi
key = "YOUR_KEY"
keyfrom = "YOUR_KEYFROM"

word = ARGV[0]
output_phonetic = ""
output_explains = ""

if word == nil
	puts "[Query require]"
	exit
end

uri =uri = URI.parse(URI.encode("http://fanyi.youdao.com/openapi.do?keyfrom=#{keyfrom}&key=#{key}&type=data&doctype=json&version=1.1&q=#{word}"))
http = Net::HTTP.new(uri.host, uri.port)
res_json = JSON.parse(http.request(Net::HTTP::Get.new(uri.request_uri)).body)

begin
	puts "\n"
	puts "[query]".ljust(11) + res_json["query"]
	
	res_json["basic"].each do |k,v|
		output_phonetic += "(#{k}) #{v}" + ";" if k.include?("phonetic")
		output_explains = "[#{k}]".ljust(11) +  res_json["basic"]["explains"].join("\n           ") if k == "explains"
	end
	puts output_explains
	print "[Web]".ljust(11)
	res_json["web"].each do |f|
		print f["key"] + ": " + f["value"].join(", ") + "\n           "
	end
	puts "\n"
	puts output_phonetic
	puts "\n"
rescue => e
	puts res_json.to_json
	puts "\n"
	puts e
end
