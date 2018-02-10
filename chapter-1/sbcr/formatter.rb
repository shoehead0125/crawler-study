class Formatter
  def initialize(site)
    @url = site.url
    @title = site.title
  end
  attr_reader :url, :title
end

class TextFormatter < Formatter
  def format(url_title_time_ary)
    s = "Title: #{title}\nURL: #{ url }\n\n"
    url_title_time_ary.each do |aurl, atitle, atime|
      s << "* (#{ atime }#{ atitle })\n"
      s << "    #{ aurl }\n"
    end
    s
  end
end

class RSSFormatter < Formatter
  def format(url_title_time_ary)
    RSS::Maker.make('2.0') do |maker|
      maker.channel.updated = Time.now.to_s
      maker.channel.link = url
      maker.channel.title = title
      maker.channel.description = title
      url_title_time_ary.each do |aurl, atitle, atime|
        maker.items.new_item do |item|
          item.link = aurl
          item.updated = atime
          item.description = atitle
        end
      end
    end
  end
end
