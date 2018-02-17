# _*_ coding: utf-8 _*_
require 'anemone'
require 'nokogiri'
require 'kconv'
require 'pry'

urls = [
    'https://www.amazon.co.jp/gp/bestsellers/videogames/4731377051',
    'https://www.amazon.co.jp/gp/bestsellers/videogames/2494234051',
    'https://www.amazon.co.jp/gp/bestsellers/books/466282',
    'https://www.amazon.co.jp/gp/bestsellers/books/492062'
  ]

Anemone.crawl(urls, depth_limit: 0, skip_query_strings: true) do |anemone|
  anemone.on_every_page do |page|
    # sleepいれないとHTMLが生成される前に動いてしまうため、指定の文字列が拾えない？
    sleep(1)
    doc = Nokogiri::HTML.parse(page.body.toutf8)

    category = doc.xpath("//*[@id='zg_browseRoot']/ul/li/a").text
    sub_category = doc.xpath("//*[@id=\"zg_listTitle\"]/span").text

    puts category + "/" + sub_category
  end
end
