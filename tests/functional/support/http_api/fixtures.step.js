const { Given } = require('@cucumber/cucumber')
const nock = require('nock')

Given(
    /^(?:I )?mock a (GET|POST) http call to forward request body for path (.+)/,
    function (method, path) {
        if (method === 'GET') {
            nock('http://fake.io')
                .get(path)
                .reply(200, (uri, body) => body)
            return
        }
        nock('http://fake.io')
            .post(path)
            .reply(200, (uri, body) => body)
    }
)
