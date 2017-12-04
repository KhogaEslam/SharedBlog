# SharedBlog

* Ruby version

    2.4.2

* Rails Version

    5.1.4

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install
```

Next, migrate the database:

```
$ rails db:migrate
```

Then, seed the data:

```
$ rails db:seed
```

_To login as admin you can use_ 

email: admin@sharedblog.com

password: P@ssw0rd


Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

**Supported**

-  User can signs up.
-  User can sign in.
-  User can create Articles.
-  User can list all Articles.
-  User can read an Article.
-  User can favorite/unfavorite Article.
-  User can list all his favorite Articles.
-  User can follow/unfollow other users.
-  User can list his followings.
-  User can list Articles from his followings.

**Not Supported**

- Make user admin [Only one admin as mentioned above]
- ...

