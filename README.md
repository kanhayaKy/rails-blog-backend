# PRE-REQUISITES
- Ruby 3
- Rails 7
- Postgres Database

# Starting the project using docker
- Start the docker containers : `docker-compose -f docker-compose.yml up --build`
- Create the database using   : `docker-compose run backend rails db:create`
- Run the migration files     : `docker-compose run backend rails db:migrate`


# Starting the project without docker
- Ensure postgres is running
- Create the database using : `rails db:create`
- Run the migration files   : `rails db:migrate`
- Start the rails server    : `rails serve`


# Features
 - [x] User Creation and Authentication
 - [x] Post Create, Update, Read and Destroy
 - [x] Like and Dislike posts
 - [x] Commenting on a post
 ...

# API Documentation
...


