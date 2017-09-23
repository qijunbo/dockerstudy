#MYSQL

# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

* Quick summary
* Version
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

* Summary of set up
* Configuration
* Dependencies
* Database configuration
* How to run tests
* Deployment instructions

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact


Study Notes:
--
the script ** setDBurl.sh ** doesn't work, but I learned this things.
- About Linux Command **sed**

**The difference between " and ' **

The place holder {mysqldburl} will be replaced with the output of **uname**

```
sed  "s/{mysqldburl}/`uname`/g" ./application-prod.yml.ftl
```

The place holder {mysqldburl} will be replaced with the string `uname`

```
sed  's/{mysqldburl}/`uname`/g' ./application-prod.yml.ftl
```





