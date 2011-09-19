Given /^I have no registrations$/ do
  Registration.delete_all
end

Given /^I (only )?have registrations titled "?([^\"]*)"?$/ do |only, titles|
  Registration.delete_all if only
  titles.split(', ').each do |title|
    Registration.create(:username => title)
  end
end

Then /^I should have ([0-9]+) registrations?$/ do |count|
  Registration.count.should == count.to_i
end

###
# new registration
###

Given /^I am a visitor$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I have no registration$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I have a page titled "([^"]*)" with a custom url "([^"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When /^I go to the join us page$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end


#
#Given /^I am a logged in refinery user$/ do
#  pending # express the regexp above with the code you wish you had
#end
#
#When /^I go to the list of registrations$/ do
#  pending # express the regexp above with the code you wish you had
#end
#
#Then /^I should see "([^"]*)"$/ do |arg1|
#  pending # express the regexp above with the code you wish you had
#end
#
#When /^I follow "([^"]*)"$/ do |arg1|
#  pending # express the regexp above with the code you wish you had
#end
#
#When /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
#  pending # express the regexp above with the code you wish you had
#end
#
#When /^I press "([^"]*)"$/ do |arg1|
#  pending # express the regexp above with the code you wish you had
#end

#
#When /^I follow "([^"]*)" within "([^"]*)"$/ do |arg1, arg2|
#  pending # express the regexp above with the code you wish you had
#end
#
#Then /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
#  pending # express the regexp above with the code you wish you had
#end
#
#Then /^I press "([^"]*)"$/ do |arg1|
#  pending # express the regexp above with the code you wish you had
#end
#
#Then /^I should be on the list of registrations$/ do
#  pending # express the regexp above with the code you wish you had
#end
#
#Then /^I should not see "([^"]*)"$/ do |arg1|
#  pending # express the regexp above with the code you wish you had
#end
#
#Given /^I only have (\d+) new registration titled UniqueTitleOne$/ do |arg1|
#  pending # express the regexp above with the code you wish you had
#end
#
#Then /^I should have (\d+) accepted registrations$/ do |arg1|
#  pending # express the regexp above with the code you wish you had
#end
#
#Then /^I should have (\d+) rejected registrations$/ do |arg1|
#  pending # express the regexp above with the code you wish you had
#end

#
#----
#
#  @registrations-valid @valid
#  Scenario: Create Valid Registration
#    When I go to the list of registrations
#    And I follow "Add New Registration"
#    And I fill in "Username" with "This is a test of the first string field"
#    And I press "Save"
#    Then I should see "'This is a test of the first string field' was successfully added."
#    And I should have 1 registration
#
#  @registrations-invalid @invalid
#  Scenario: Create Invalid Registration (without username)
#    When I go to the list of registrations
#    And I follow "Add New Registration"
#    And I press "Save"
#    Then I should see "Username can't be blank"
#    And I should have 0 registrations
#
#  @registrations-edit @edit
#  Scenario: Edit Existing Registration
#    Given I have registrations titled "A username"
#    When I go to the list of registrations
#    And I follow "Edit this registration" within ".actions"
#    Then I fill in "Username" with "A different username"
#    And I press "Save"
#    Then I should see "'A different username' was successfully updated."
#    And I should be on the list of registrations
#    And I should not see "A username"
#
#  @registrations-duplicate @duplicate
#  Scenario: Create Duplicate Registration
#    Given I only have registrations titled UniqueTitleOne, UniqueTitleTwo
#    When I go to the list of registrations
#    And I follow "Add New Registration"
#    And I fill in "Username" with "UniqueTitleTwo"
#    And I press "Save"
#    Then I should see "There were problems"
#    And I should have 2 registrations
#
#  @registrations-accept @accept
#  Scenario: Accept Registration
#    Given I only have 1 new registration titled UniqueTitleOne
#    When I go to the list of registrations
#    And I follow "Accept this registration"
#    Then I should see "'UniqueTitleOne' was successfully accepted."
#    And I should have 1 accepted registrations
#
#  @registrations-reject @reject
#  Scenario: Reject Registration
#    Given I only have registrations titled UniqueTitleOne
#    When I go to the list of registrations
#    And I follow "Reject this registration"
#    Then I should see "'UniqueTitleOne' was rejected."
#    And I should have 1 rejected registrations
