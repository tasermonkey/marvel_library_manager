require "marvel_library_manager/version"
require 'digest'
require 'uri'
require 'open-uri'
require 'nokogiri'
require 'pp'
require 'net/http'

require 'json'

module MarvelLibraryManager
  @public_api_key = ENV["MARVEL_PUB_API_KEY"]
  @private_api_key = ENV["MARVEL_PRIV_API_KEY"]
  @series_id = ENV["MARVEL_SERIES_ID"]
  @base_url = "http://gateway.marvel.com/v1/public/series/#{@series_id}/comics"
  @marvel_site_cookie = ENV["MARVEL_SITE_COOKIE"]

  def self.get_params
    ts = (Time.now.to_f * 1000).to_i.to_s
    msg = ts + @private_api_key + @public_api_key
    hash = Digest::MD5.hexdigest msg
    [["ts", ts], ["apikey", @public_api_key], ["hash", hash]]
  end

  def self.run(args)
    raise 'Must set MARVEL_PUB_API_KEY env variable' unless @public_api_key
    raise 'Must set MARVEL_PRIV_API_KEY env variable' unless @private_api_key
    raise 'Must set MARVEL_SERIES_ID env variable' unless @series_id
    raise 'Must set MARVEL_SITE_COOKIE env variable' unless @marvel_site_cookie
    puts "Data provided by Marvel. © 2014 Marvel"
    p = get_params() << ["orderBy", "issueNumber"] << ["noVariants", "true"] << ["hasDigitalIssue", "true"] << ["limit", "99"] << ["offset", "0"]
    to_hit = URI(@base_url)
    to_hit.query = URI.encode_www_form(p)
    puts "Hitting #{to_hit.to_s}"
    page = nil
    open (to_hit) do |f|
      page = JSON.parse(f.read)
    end
    pp page["data"]
    series_id = page["data"]["results"].map do |c|
      urls = c["urls"].select do |u|
        u["type"] == 'detail'
      end
      urls = urls.map do |u|
        u["url"]
      end
      [c["id"],c["title"], urls[0]]
    end
    total = page["data"]["total"]
    offset = page["data"]["offset"]
    return_limit = page["data"]["limit"]
    count = page["data"]["count"]
    puts "Total: #{total}, Offset: #{offset}, limit: #{return_limit}, count: #{count}"
    pp series_id
    series_id.each do |s|
      add_to_library s[0], s[2]
      sleep(1.0/4.0)
    end
    puts "Data provided by Marvel. © 2014 Marvel"
  end

  def self.run2(args)
    series_id = [["15943", "Thor (2007) #1", "http://marvel.com/comics/issue/15943/thor_2007_1?utm_campaign=apiRef&utm_source=e436aac408f146765bc436ba576d6f30"]]
    add_to_library series_id[0][0], series_id[0][2]
  end

  def self.add_to_library(id, resource)
    url = URI("http://marvel.com/my_account/my_must_reads")
    puts url
    req = Net::HTTP::Post.new(url)
    req.set_form_data  'id' => id
    req['Referer'] = resource
    req['X-Requested-With'] = "XMLHttpRequest"
    req['Origin'] = "http://marvel.com"
    req['Cookie'] = @marvel_site_cookie
    res = Net::HTTP.start(url.hostname, url.port) do |http|
      http.request(req)
    end
    puts res.body
  end

end
