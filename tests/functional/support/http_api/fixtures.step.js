const {Given} = require('@cucumber/cucumber')
const nock = require('nock')
const fs = require('fs');

Given(
    /^(?:I )?mock a POST http call to forward request body for path (.+)/,
    function (path) {
        nock('http://fake.io')
            .post(path)
            .reply(200, (uri, body) => body)
        nock('http://mysite.com/api/v1')
            .post(path)
            .reply(200, (uri, body) => body.response.jsonBody.data)
    }
)

Given(
    /^(?:I )?mock a GET http call from (.+) to forward request body for path (.+)/,
    function (filePath, uri) {
        const file = `tests/functional/features/${filePath}`
        console.log(file)
        console.log(readJsonFile(file))
        nock('http://fake.io')
            .get(uri)
            .reply(200, readJsonFile(file))
        nock('http://mysite.com/api/v1')
            .get(uri)
            .reply(200, readJsonFile(file).response.jsonBody.data)

    }
)

const readJsonFile = (filePath) =>{
    return JSON.parse(fs.readFileSync(filePath))
}
