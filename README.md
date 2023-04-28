# STORE_BACKEND
* Ruby version 3.0.0
* Rails version 6.1.7.3

# DEVELOP SETUP

```sh
bundle install
bundle exec rake app:update:bin
```

## To run store_backend server

```
 bundle exec rails s -p 3000
```
There is a POSTMAN json on `store_collection.postman_collection.json` , that contains the main structure of the HTTP requests


# TESTING
## Run tests

```sh
rspec
```
