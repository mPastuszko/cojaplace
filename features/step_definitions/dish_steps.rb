# encoding: UTF-8

Given(/^nobody has selected any dish for "(.*?)" for today yet$/) do |user|
  today = Time.now.strftime("%D")
  database[:order_items].filter(date: today, user: user).delete
end
