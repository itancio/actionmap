Feature: Display news' title, description, issue and links on news items page

As a polityphile
I want to be able to identify the issues associated with a news article
so that I can quickly search quickly the relevant issues tied with a political figure

Background: we are on the news article page
  Given the following representatives exist:
  | name                    | title                           |
  | Joseph R. Biden.        | President of the United States  |
  | Brad Lander             | New York City Comptroller       |
  | Jumaane D. Williams     | New York Public Advocate        |
  | Alexander Ocasio Cortez |                                 |

  Then 4 seed representatives should exist

  And the following news items exist:
  | title     | link                                           | issue         | description    | representative_id |
  | Title 1   | https://www.google.com/search?q=free%speech    | Free Speech   | Lorem Ipsum 1  | 001               |
  | Title 2   | https://www.google.com/search?q=free%speech    | Free Speech   | Lorem Ipsum 2  | 001               |
  | Title 3   | https://www.google.com/search?q=free%speech    | Free Speech   | Lorem Ipsum 3  | 001               |
  | Title 4   | https://www.google.com/search?q=free%speech    | Free Speech   | Lorem Ipsum 4  | 001               |
  | Title 5   | https://www.google.com/search?q=free%speech    | Free Speech   | Lorem Ipsum 5  | 002               |
  | Title 6   | https://www.google.com/search?q=immigration    | Immigration   | Lorem Ipsum 6  | 003               |
  | Title 7   | https://www.google.com/search?q=terrorism      | Terrorism     | Lorem Ipsum 7  | 002               |
  | Title 8   | https://www.google.com/search?q=unemployment   | Unemployment  | Lorem Ipsum 8  | 002               |
  | Title 9   | https://www.google.com/search?q=student%loans  | Student Loans | Lorem Ipsum 9  | 002               |
  | Title 10  | https://www.google.com/search?q=homelessness   | Homelessness  | Lorem Ipsum 10 | 002               |

  Then 10 seed news item should exist
  
Scenario: see if issues column exists on news item page
  Given I am on representatives page
  And I fill in "address" with "San Francisco"
  And I press "Search"
  And I follow the first "News Articles" link
  Then I should see "Issue"

# TODO: Create a scenario to check that one of the issues display on news items page
# To make this work: Add GET ... on routes.rb, 
   Given I am logged in
   And I visit the news items with representative id 001
   Then I should see "Free Speech"