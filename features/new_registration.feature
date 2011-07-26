@registrations
Feature: Registration
  In order to be member 
  As an visitor
  I want to create an registration

  Background:
    Given I am a visitor
    And I have no registration
	And I have a page titled "Join us" with a custom url "/join-us"
	And I have a page titled "Thank You" with a custom url "/join-us/thank-you"

  Scenario: Join us page
    When I go to the join us page
    Then I should see "Name"
    And I should see "E-mail"
    And I should see "Personal info"
