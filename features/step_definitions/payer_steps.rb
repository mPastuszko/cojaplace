# encoding: UTF-8

Given(/^nobody has chosen payer yet for today$/) do
  today_order = database[:orders].first(date: today)
  if today_order
    database[:orders].filter(date: today).update(payer: '')
  end
end

Given(/^payer "(.*?)" has already been selected for (today|yesterday)$/) do |payer, day|
  date = self.send(day)
  order = database[:orders].first(date: date)
  database[:orders].insert(:date => date) unless order
  database[:orders].filter(date: date).update(payer: payer)
end

When(/^I select "(.*?)" as a payer$/) do |payer|
  find_field('payer').select(payer)
end


Then(/^payer should not be selected$/) do
  find_field('payer').value.should be_empty
end


Then(/^payer "(.*?)" should be selected$/) do |payer|
  find_field('payer').value.should == payer
end
