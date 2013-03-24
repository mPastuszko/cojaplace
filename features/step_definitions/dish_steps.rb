# encoding: UTF-8

Given(/^nobody has selected any dish for "(.*?)" for today yet$/) do |user|
  today = Time.now.strftime("%D")
  database[:order_items].filter(date: today, user: user).delete
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
