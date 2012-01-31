Given /^I have no submissions$/ do
  Submission.delete_all
end

Given /^I (only )?have submissions titled "?([^\"]*)"?$/ do |only, titles|
  Submission.delete_all if only
  titles.split(', ').each do |title|
    Submission.create(:first_name => title)
  end
end

Then /^I should have ([0-9]+) submissions?$/ do |count|
  Submission.count.should == count.to_i
end
