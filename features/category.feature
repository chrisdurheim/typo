Feature: Admin Categories
  As a blog administrator
  In order to ensure consistent, conslidated usage of categories
  I want to be able to add and edit blog categories on my site

  Background:
    Given the blog is set up
    
#    And the following categories exist:
#      | profile_id | login | name | password | email | state |
#      | 2 | user_1 | User1 | 1234567 | foo@example.com | active |
#      | 3 | user_2 | User2 | 1234567 | bar@example.com | active |

  Scenario: An admin can go to the category add edit page
    Given I am logged in as "admin" with password "aaaaaaaa"
    When I go to the new category page
    Then I should be on the new category page
    And I should see "Categories"
