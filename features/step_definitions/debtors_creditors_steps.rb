# encoding: UTF-8

Then(/^I should have no (debtors|creditors)$/) do |type|
  with_scope(type.prepend('.')) do
    page.should_not have_selector('dt')
  end
end
