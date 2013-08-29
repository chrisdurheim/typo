Feature: Merge Articles
  As a blog administrator
  In order to minimize redundant reading for my visitors
  I want to be able to merge articles within my blog

  Background:
    Given the blog is set up
    
    And the following users exist:
      | profile_id | login | name | password | email | state |
      | 2 | user_1 | User1 | 1234567 | foo@example.com | active |
      | 3 | user_2 | User2 | 1234567 | bar@example.com | active |

    And the following articles exist:
      | id | title | author | user_id | body | allow_comments | published | published_at | state | type |
      | 3 | Article1 | user_1 | 2 | Content1 | true | true | 2012-23-11 21:30:00 | published | Article |
      | 4 | Article2 | user_2 | 3 | Content2 | true | true | 2012-24-11 22:00:00 | published | Article |

    And the following comments exist:
      | id | type | author | body | article_id | user_id | created_at |
      | 1 | Comment | user_1 | Comment1 | 3 | 2 | 2012-23-11 21:31:00 |
      | 2 | Comment | user_1 | Comment2 | 4 | 2 | 2012-24-11 22:01:00 |

  Scenario: A non-admin (i.e. user id 11) cannot merge articles
    Given I am logged in as "user_1" with password "1234567"
    When I go to the edit page for article 3
    Then I should be on the edit page for article 3
    And I should not see "Merge Articles"
  
  Scenario: An admin (i.e. user id 10) is given the option to merge articles
    Given I am logged in as "admin" with password "aaaaaaaa"
    When I go to the edit page for article 3
    Then I should be on the edit page for article 3
    And I should see "Merge Articles"
    When I fill in "merge_with" with "4"
    And I press "Merge"
    Then I should be on the admin content page
    And I should see "Articles successfully merged!"

  Scenario: The merged articles should contain the text of both previous articles
    Given the articles with ids "3" and "4" were merged
    And I am on the home page
    Then I should see "Article1"
    When I follow "Article1"
    Then I should see "Content1"
    And I should see "Content2"

  Scenario: The merged article should have one author (either of the originals)
    Given the articles with ids "3" and "4" were merged
    Then "administrator" should be the author of 1 articles
    And "blogpublisher" should be the author of 0 articles

  Scenario: The merged articles should contain the comments of both previous articles
    Given the articles with ids "3" and "4" were merged
    And I am on the home page
    Then I should see "Article1"
    When I follow "Article1"
    Then I should see "Comment1"
    And I should see "Comment2"

  Scenario: The merged articles should have either of the original titles
    Given the articles with ids "3" and "4" were merged
    And I am on the home page
    Then I should see "Article1"
    And I should not see "Article2"
