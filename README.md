
# README

## How to develop locally

### Database setup

Change to the postgres user on the os
Create a PostgreSQL super user role that has the name of your OS user and set no password:
Go back to your original user.

```shell
sudo su postgres
createuser -s <<YOUR_USERNAME>>
exit
```

## Start the rails server

The asset precompilation is done in a separate process so regular `rails s` wil not build the assets.
Run the dev script to run rails server and the asset compiler in one process

```shell
bin/dev
```

### AuthSch login

```shell
cp .env.example .env
```
Set the client id and secret from the AuthSch developer console.





