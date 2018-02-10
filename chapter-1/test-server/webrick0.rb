#!/usr/bin/env ruby

require 'webrick'

Thread.start{
  WEBrick::HTTPServer.new(DocummentRoot: '/Users/shoe_head/programing study/勉強会/tech-camp-ob/warehouse/test.html',
    Port: 7777, BindAddress: '127.0.0.1').start
}
gets
