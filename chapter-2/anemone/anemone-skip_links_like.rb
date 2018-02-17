# _*_ coding: utf-8 _*_
require 'anemone'
require 'pry'

Anemone.crawl("http://yahoo.co.jp") do |anemone|
  anemone.skip_links_like /\/r\//
  anemone.on_every_page do |page|
    puts page.url
  end
end
