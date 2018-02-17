# _*_ coding: utf-8 _*_
require 'anemone'
require 'pry'

urls = [
    'https://www.amazon.co.jp/gp/bestsellers/books',
    'https://www.amazon.co.jp/gp/bestsellers/videogames'
  ]

Anemone.crawl(urls, depth_limit: 1, skip_query_strings: true) do |anemone|
  anemone.focus_crawl do |page|
    page.links.keep_if { |link|
      link.to_s.match(/\/gp\/bestsellers\/books|\/gp\/bestsellers\/videogames/)
    }
  end

  PATTERN = %r[466282\/+|492062\/+|2494234051\/+|4731377051\/+]
  anemone.on_pages_like(PATTERN) do |page|
    puts page.url
  end
end
