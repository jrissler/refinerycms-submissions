@submissions
Feature: Submissions
  In order to have submissions on my website
  As an administrator
  I want to manage submissions

  Background:
    Given I am a logged in refinery user
    And I have no submissions

  @submissions-list @list
  Scenario: Submissions List
   Given I have submissions titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of submissions
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @submissions-valid @valid
  Scenario: Create Valid Submission
    When I go to the list of submissions
    And I follow "Add New Submission"
    And I fill in "First Name" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 submission

  @submissions-invalid @invalid
  Scenario: Create Invalid Submission (without first_name)
    When I go to the list of submissions
    And I follow "Add New Submission"
    And I press "Save"
    Then I should see "First Name can't be blank"
    And I should have 0 submissions

  @submissions-edit @edit
  Scenario: Edit Existing Submission
    Given I have submissions titled "A first_name"
    When I go to the list of submissions
    And I follow "Edit this submission" within ".actions"
    Then I fill in "First Name" with "A different first_name"
    And I press "Save"
    Then I should see "'A different first_name' was successfully updated."
    And I should be on the list of submissions
    And I should not see "A first_name"

  @submissions-duplicate @duplicate
  Scenario: Create Duplicate Submission
    Given I only have submissions titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of submissions
    And I follow "Add New Submission"
    And I fill in "First Name" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 submissions

  @submissions-delete @delete
  Scenario: Delete Submission
    Given I only have submissions titled UniqueTitleOne
    When I go to the list of submissions
    And I follow "Remove this submission forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 submissions
 