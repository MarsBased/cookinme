# README

Cookin.me features an easy, clean and intuitive user interface that will help you organize your cooking recipes the way you want: create cookbooks and move recipes between them. The smooth transitions provide a pleasant experience when combined with in-line editing. You will breeze through your recipes collection!

Currently in development and not yet production ready, we have decided to open the source code to the community to show our work and help other people developing similar software.

## System dependencies

### Ruby 2.1.0 and Ruby on Rails 4.0.3

At MarsBased we love to use the last versions of the software we use and try its newest features. The bad thing is that we couldn't give support for any other Ruby or Rails versions. Try it at your own risk.

### Mysql

Martians like Mysql but respect their Postgres friends. Migration to other SQL databases should be painless.

### ImageMagick

Image processing to generate awesome thumbnails of the recipe photos you upload!

## External services sependencies

### Facebook and Google Authentication

To signup and login with your Facebook or Google accounts, you need to have a valid API key and secret from the two services.

Authentication via email is offered if you don't want to mess with Facebook or Google accounts configuration.

### Mandrill email sending

We send emails through Mandrill (http://mandrill.com). We use templates inside Mandrill to send our emails. See CookinmeMailer for more information.
Only password recovery emails are used by now, so it's safe to ignore this if you don't want to explore password recovery features.

### Amazon S3

Only a production requeriment as the development enviorentment uses the file storage to store images.

## Configuration

Cookinme is configured with Figaro (https://github.com/laserlemon/figaro).
You need to create a YAML file under config named application (config/application.yml) and configure the following keys:

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* MANDRIL_API_KEY
* FACEBOOK_KEY
* FACEBOOK_SECRET
* GOOGLE_KEY
* GOOGLE_SECRET

The application is not dependant on any of this keys but don't expect the application to manage failure if you try to use one of the services without the proper configuration.

## First time installation

* bundle install
* bundle exec rake db:create
* bundle exec rake db:migrate
* bundle exec spring binstub --all  (if you want to use the spring preloader: https://github.com/rails/spring)

## Deployment

Cookinme is planned to be deployed to an Unicorn/nginx stack. Currently the deploying is not fully working but we are working on this :)

## Test coverage

We didn't start this project using a TDD approach. Regretting this decision after having to face some important refactorings we are building our test stack from the bottom to the top.

We won't continue the development until we feel confident with the test coverage. We will update this section when we achieve this milestone. Stay tuned and any help with this is welcome :)