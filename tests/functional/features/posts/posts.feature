@posts
Feature: Get posts

    Scenario: I can create a new post
        Given I mock a POST http call to forward request body for path /posts
        And set request json body from create_post
        When I POST http://mysite.com/api/v1/posts
        Then response status code should be 200
        And response json body should match snapshot
            | field       | matcher | value        |
            | post.userId | equal   | 10((number)) |
            | post.id     | equals  | 1((number))  |

    Scenario: I get a list of posts
        Given I mock a GET http call to forward request body for path /posts
        When I GET http://mysite.com/api/v1/posts
        Then response status code should be 200
