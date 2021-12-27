@snapshot
Feature: Using snapshot step definitions

    Scenario: Snapshot testing on an API
        Given I mock a POST http call to forward request body for path /users/yaml
        And set request json body from file2
        When I POST http://fake.io/users/yaml
        Then response body should match snapshot
        
    Scenario: Snapshot testing on an API for GET request
        Given I mock a GET http call to forward request body for path /users/yaml
        When I GET http://fake.io/users/yaml
        Then response status code should be 200

    Scenario: Snapshot testing on an API with json file mock
        Given I mock a POST http call to forward request body for path /users/json
        And set request json body from file2
        When I POST http://fake.io/users/json
        Then response status code should be 200
        And response body should match snapshot

    Scenario: Snapshot testing on an API with json file mock for GET request
        Given I mock a GET http call to forward request body for path /users/json
        When I GET http://fake.io/users/json
        Then response status code should be 200

    Scenario: Snapshot testing on cli
        When I run command echo test
        Then exit code should be 0
        And stdout output should match snapshot

    Scenario: Snapshot testing on files
        Given I set cwd to tests/functional/features/snapshot/fixtures
        Then file file.yaml should match snapshot

    Scenario: Snapshot testing on a json API
        Given I mock a POST http call to forward request body for path /users/yaml
        And set request json body from file
        When I POST http://fake.io/users/yaml
        Then response json body should match snapshot
            | field      | matcher | value   |
            | id         | type    | number  |
            | first_name | equals  | Raphaël |
            | last_name  | equals  | Benitte |
            | gender     | equals  | male    |

    Scenario: Testing on a json API without snapshot
        Given I mock a POST http call to forward request body for path /users/yaml
        And set request json body from file
        When I POST http://fake.io/users/yaml
        Then json response should match
            | field      | matcher | value   |
            | id         | type    | number  |
            | first_name | equals  | Raphaël |
            | last_name  | equals  | Benitte |
            | gender     | equals  | male    |

    Scenario: Snapshot testing on a CLI with json output
        When I run command echo {"gender": "male", "name": "john"}
        Then exit code should be 0
        And stdout json output should match snapshot
            | field  | matcher | value |
            | gender | equals  | male  |
            | name   | equal   | john  |

    Scenario: Snapshot testing on a json file
        Given I set cwd to tests/functional/features/snapshot/fixtures
        Then json file file2.json content should match snapshot
            | field  | matcher | value  |
            | gender | type    | string |
            | id     | type    | number |
