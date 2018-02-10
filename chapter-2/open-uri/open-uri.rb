#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'open-uri'

open(
  "http://news.yahoo.co.jp") {
  |f| f.each_line { |line| p line }
}
