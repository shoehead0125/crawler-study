# _*_ coding: utf-8 _*_
require 'anemone'
require 'pry'

urls = [
    'https://www.amazon.co.jp/gp/bestsellers/videogames/4731377051',
    'https://www.amazon.co.jp/gp/bestsellers/videogames/2494234051',
    'https://www.amazon.co.jp/gp/bestsellers/books/466282',
    'https://www.amazon.co.jp/gp/bestsellers/books/492062'
  ]

Anemone.crawl(urls, depth_limit: 0, skip_query_strings: true) do |anemone|
  anemone.on_every_page do |page|
    puts page.url
  end
end
