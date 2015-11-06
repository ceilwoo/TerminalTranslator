# terminal translator (en <-> chs)
# 命令行中英翻译机
# by ceil 20150905
# ----------------
# v1.1 add voice for mac os, add '-v' to active, Example: ruby translate.rb ceil -v
#      support short sentence
# v1.0 20150905

require 'net/http'
require 'uri'
require 'json'

############################################
# KEY申请:  http://fanyi.youdao.com/openapi
############################################
key = "YOUR_KEY"
keyfrom = "YOUR_KEYFROM"

############################################
# Main function
############################################
@enable_voide = false
@include_chinese = false
@debug_mode = false

argv_list = []
ARGV.each do |x|
	argv_list << x if x != "-v" and x != "-d"
	@enable_voide = true if x == "-v"
	@debug_mode = true if x == "-d"
end

word = argv_list.join(" ")

@include_chinese = true if (word =~ /\p{Han}/) != nil

if word == ""
	puts "[Parameter Require]"
	exit
end

output_phonetic = ""
output_explains = ""

uri = URI.parse(URI.encode("http://fanyi.youdao.com/openapi.do?keyfrom=#{keyfrom}&key=#{key}&type=data&doctype=json&version=1.1&q=#{word}"))

puts "translating..."

http = Net::HTTP.new(uri.host, uri.port)
res_json = JSON.parse(http.request(Net::HTTP::Get.new(uri.request_uri)).body)

p res_json if @debug_mode

begin
	puts "\n"
	puts "[query]".ljust(13) + res_json["query"]
	puts "[translation]".ljust(13) + res_json["translation"].join(" ") if res_json["translation"]
	if res_json["basic"]
		res_json["basic"].each do |k,v|
			output_phonetic += "(#{k}) #{v}" + ";" if k.include?("phonetic")
			output_explains = "[#{k}]".ljust(13) +  res_json["basic"]["explains"].join("\n             ") if k == "explains"
		end
	end

	puts output_explains
	print "[Web]".ljust(13)
	if res_json["web"]
		res_json["web"].each do |f|
			print f["key"] + ": " + f["value"].join(", ") + "\n             "
		end
	end
	puts "\n"
	puts output_phonetic
	puts "\n"
	system "say #{word}" if !@include_chinese and @enable_voide 
rescue => e
	puts res_json.to_json
	puts "\n"
	puts e
end
