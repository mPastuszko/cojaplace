# encoding: UTF-8

Given(/^nobody has selected any dish for "(.*?)" for today yet$/) do |user|
  database[:order_items].filter(date: today, user: user).delete
end

Given(/^someone has selected "(.*?)" costing "(.*?)" for "(.*?)" for today$/) do |dish, price, user|
  database[:order_items].insert(date: today, dish: dish, price: price.to_f, user: user)
end

Then(/^the last dish should be empty$/) do
  with_scope(".dishes .dish:last-child") do
    all('input').each { |i| i.value.to_s.should be_empty }
  end
end

Then(/^the last dish should be for "(.*?)"$/) do |user|
  with_scope(".dishes .dish:last-child") do
    page.should have_css("select option[selected]:contains('#{user}')")    
  end
end
