require 'selenium-webdriver'
require 'pry'

driver = Selenium::WebDriver.for :chrome

driver.manage.timeouts.page_load = 10

driver.navigate.to 'https://twitter.com/search-home'

# なぜが必要？？ページが読み込めていない？？
sleep(0.5)

elements = driver.find_elements(:xpath, "//ul[@class='trend-items js-trends']/li/a")

elements.each do |element|
  puts element.text
end

driver.quit
