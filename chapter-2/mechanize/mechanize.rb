require 'dotenv'
require 'mechanize'

Dotenv.load('../../.env')

uri = URI.parse('https://twitter.com/login')
agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'
page = agent.get(uri)

next_page = page.form_with(action: 'https://twitter.com/sessions') do |form|

  form.fields[0].value = ENV['TWITTER_EMAIL']
  form.fields[1].value = ENV['TWITTER_PASSWORD']
end.submit

puts next_page
