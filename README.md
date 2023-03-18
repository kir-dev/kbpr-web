
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

### AuthSch login

```shell
cp .env.example .env
```
Set the client id and secret from the AuthSch developer console.




