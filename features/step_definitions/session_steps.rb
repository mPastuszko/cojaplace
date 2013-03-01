# encoding: UTF-8

Given /^I am not logged in$/ do

end

Given /^I am logged in as "(.*?)"$/ do |user|
  visit path_to('welcome page')
  fill_in('username', with: user)
  click_button("No już, dalej!")
end
