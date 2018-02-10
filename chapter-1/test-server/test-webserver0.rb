#!/Users/shoe_head/.rbenv/shims/ruby
# -*- coding: utf-8 -*-
require 'webrick'

class TestContentServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(req, res)
    res.body = get_body(req.path)
    res.content_type = WEBrick::HTTPUtils.mime_type(
      req.path_info, WEBrick::HTTPUtils::DefaultMimeTypes)
  end

  def get_body(path)
    return html_content(path) if path =~ /\.html$/
    return txt_content(path) if path =~ /\.txt$/
    'dummy'
  end

  def html_content(path)
    node = path[0..-6]
    <<HTML
<html><head><title>#{path}</title></head>
<body><p>
<a href="#{node}/1.html">#{node}/1.html</a><br>
<a href="#{node}/2.html">#{node}/2.html</a><br>
<a href="#{node}.txt">#{node}.txt</a><br>
<a href="http://localhost:7777#{node}.htm">#{node}.htm</a><br>
<a href='/1.html'>/1.html</a><br>
</p></body></html>
HTML
  end

  def txt_content(path)
    "This is #{path}"
  end
end

srv = WEBrick::HTTPServer.new(BindAddress: '127.0.0.1', Port: 7777)
srv.mount('/', TestContentServlet)
trap('INT') { srv.shutdown }
srv.start
