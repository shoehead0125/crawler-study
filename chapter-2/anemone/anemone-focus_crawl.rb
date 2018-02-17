# _*_ coding: utf-8 _*_
require 'anemone'
require 'pry'

Anemone.crawl("https://www.amazon.co.jp/ranking", depth_limit: 1) do |anemone|
  anemone.focus_crawl do |page|
    page.links.keep_if { |link|
      link.to_s.match(/\/books/)
    }
  end
  anemone.on_every_page do |page|
    puts page.url
  end
end
