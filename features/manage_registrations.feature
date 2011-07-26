@registrations
Feature: Registrations
  In order to have registrations on my website
  As an administrator
  I want to manage registrations

  Background:
    Given I am a logged in refinery user
    And I have no registrations

  @registrations-list @list
  Scenario: Registrations List
   Given I have registrations titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of registrations
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"


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