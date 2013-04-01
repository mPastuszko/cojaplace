# encoding: UTF-8

def within_dish_for(user, &block)
  with_scope(".dishes .dish select option[selected]:contains('#{user}')") do
    parent(2).instance_eval(&block)
  end
end

Given(/^nobody has selected any dish for "(.*?)" for today yet$/) do |user|
  database[:order_items].filter(date: today, user: user).delete
end

Given(/^someone has selected "(.*?)" costing "(.*?)" for "(.*?)" for (today|yesterday)$/) do |dish, price, user, day|
  date = self.send(day)
  database[:order_items].insert(date: self.send(day), dish: dish, price: price.to_f, user: user)
  update_register(order(date)[:restaurant], [[dish, price]])
end

Given(/^nobody has selected any dish for today yet$/) do
  database[:order_items].filter(date: today).delete
end

When(/^I select "(.*?)" costing "(.*?)" for "(.*?)" for today$/) do |dish, price, user|
  with_scope(".dishes fieldset.dish:last-of-type") do
    select user, from: 'user[]'
    fill_in 'dish[]', with: dish
    fill_in 'price[]', with: price
  end
end

When(/^I click "(.*?)" at the dish for "(.*?)"$/) do |action, user|
  within_dish_for user do
    click_link(action)
  end
end

Then(/^"(.*?)" costing "(.*?)" should be selected for "(.*?)" for today$/) do |dish, price, user|
  within_dish_for user do
    find_field('dish[]').value.should == dish
    find_field('price[]').value.should == price
  end
end

Then(/^there should be (\d+) dish(?:es)? on the list$/) do |howmany|
  all('.dishes .dish').size.should == howmany.to_i
end

Then(/^the last dish should be empty$/) do
  with_scope(".dishes fieldset.dish:last-of-type") do
    all('input').each { |i| i.value.to_s.should be_empty }
  end
end

Then(/^the last dish should be for "(.*?)"$/) do |user|
  with_scope(".dishes fieldset.dish:last-of-type") do
    page.should have_css("select option[selected]:contains('#{user}')")    
  end
end

Then(/^all fields within "(.*?)" should be disabled$/) do |container|
  with_scope(container) do
    all('input,select,button').each do |e|
      e[:disabled].should be_true
    end
  end
end

Then(/^"(.*?)" (field|button) should be disabled$/) do |label, type|
  if type == 'field'
    self.find_field(label)[:disabled].should be_true
  else
    button = all('button').find { |b| b.text =~ /#{label}/i }
    raise Capybara::ElementNotFound.new("Unable to find button '#{label}'") unless button
    button[:disabled].should be_true
  end
end
