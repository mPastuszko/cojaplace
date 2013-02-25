Then /I should see error message/ do
  error_css = 'div.alert.alert-error'
  if page.respond_to? :should
    page.should have_css(error_css)
  else
    assert page.has_css(error_css)
  end
end