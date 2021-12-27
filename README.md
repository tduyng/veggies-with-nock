# veggies-with-nock

✨ 🚀 Veggies is an awesome cucumberjs library for API/CLI testing. 
Great for testing APIs built upon Express, Koa, HAPI, Loopback and others. 
It's also the perfect companion for testing CLI applications built with commander, meow & Co.

This repository contains some examples of implementation veggies with nock. 
You can check the origin examples from [veggies repository](https://github.com/ekino/veggies)

#### To run functional tests:

```bash
$ yarn test-func

# run with a specific tag
$ yarn test-func --tags @offline

# run with multiple tags
$ yarn test-func --tags @offline --tags @github
```


You can also use `make` command:
```bash
$ make test-func
$ make test-func args="--tags @offline"
```
