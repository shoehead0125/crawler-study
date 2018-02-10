#! /usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'cgi'
require 'open-uri'
require 'rss'
require 'kconv'
require 'webrick'
require './site.rb'
require './formatter.rb'

class RSSServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(req, res)
    klass, opts = @options
    res.body =
      klass.new(opts).output(RSSFormatter).to_s
    res.content_type =
      'application/xml; charset=utf-8'
  end
end

def start_server
  srv = WEBrick::HTTPServer.new(BindAddress: '127.0.0.1', Port: 7777)
  srv.mount('/rss.xml', RSSServlet, SbcrTopics,
    url: 'http://crawler.sbcr.jp/samplepage.html',
    title: 'WWW.SBCR.JP トピックス')
  trap('INT') { srv.shutdown }
  srv.start
end

if ARGV.first == 'server'
  start_server
else
  site = SbcrTopics.new(
    url: 'http://crawler.sbcr.jp/samplepage.html',
    title: 'WWW.SBCR.JP トピックス'
  )
  case ARGV.first
  when 'rss-output'
    puts site.output RSSFormatter
  when 'text-output'
    puts site.output TextFormatter
  end
end
