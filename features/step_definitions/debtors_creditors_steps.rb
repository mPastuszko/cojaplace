# encoding: UTF-8

Then(/^I should have no (debtors|creditors)$/) do |type|
  with_scope('.' + type) do
    page.should_not have_selector('dt')
  end
end

Then(/^"(.*?)" should be my (debtor|creditor) for "(.*?)"$/) do |user, type, amount|
  with_scope('.' + type + 's') do
    page.should have_selector(".#{type}:contains('#{user}') + .amount:contains('#{amount}')")
  end
end

When(/^I hover debtor "(.*?)"$/) do |debtor|
  page.execute_script('$("a.payback-action").css("visibility", "visible")')
end

When(/^I click "(.*?)" by debtor "(.*?)"$/) do |link, debtor|
  with_scope('.debtors') do
    link = find('th', :text => debtor).parent.find_link(link)
    link.click
  end
end