Given /^user "([^\"]*)" exists(?: in (?:the)? database)?$/ do |user|
  unless database[:users].first(name: user)
    database[:users].insert(name: user)
  end
end

Given /^user "([^\"]*)" does not exists?(?: in (?:the)? database)?$/ do |user|
  if database[:users].first(name: user)
    database[:users].delete(name: user)
  end
end
