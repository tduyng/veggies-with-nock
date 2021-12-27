@httpApi @cookies
Feature: Using cookies

    Scenario: Visiting twitter home
        Given enable cookies
        When I GET https://twitter.com/
        Then response status code should be 200
        And response should have a guest_id cookie
        And response guest_id cookie should be secure
        And response guest_id cookie should not be http only
