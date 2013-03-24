# encoding: UTF-8

Given /^restaurant "(.*?)" exists$/ do |restaurant|
  unless database[:restaurants].first(name: restaurant)
    database[:restaurants].insert(name: restaurant)
  end
end

Given /^restaurant "(.*?)" does not exist$/ do |restaurant|
  if database[:restaurants].first(name: restaurant)
    database[:restaurants].delete(name: restaurant)
  end
end

Given /^restaurant "(.*?)" has been selected for today$/ do |restaurant|
  today_order = database[:orders].first(date: today)
  database[:orders].insert(:date => today) unless today_order
  database[:orders].filter(date: today).update(restaurant: restaurant)
end

When /^nobody has chosen restaurant yet for today$/ do
  today_order = database[:orders].first(date: today)
  if today_order
    database[:orders].filter(date: today).update(restaurant: '')
  end
end

When /^restaurant "(.*?)" has already been selected for today$/ do |restaurant|
  step "restaurant \"#{restaurant}\" has been selected for today"
end

Then /^restaurant should not be selected$/ do
  find_field('restaurant').value.should be_empty
end

Then /^restaurant "(.*?)" should be selected$/ do |restaurant|
  find_field('restaurant').value.should == restaurant
end

Then /^restaurant "(.*?)" should exist$/ do |restaurant|
  database[:restaurants].first(name: restaurant).should_not be_nil
end
