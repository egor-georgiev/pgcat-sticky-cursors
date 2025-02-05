# Pgcat Sticky Cursors

## What is this?
This is a repository with instructions on how to reproduce [an issue](https://github.com/postgresml/pgcat/issues/903) with PgCat connection pooler

## Prerequisites

- docker w/ compose plugin
- psql

## How to reproduce

1. start up the database server, connection pooler and client
  ```bash
  make up # bring up postgres and pgcat
  make session # run psql through a session-mode connection
  ```

2. create a cursor
  ```sql
  select * from pg_cursors; -- verify that there are no cursors in the connection
  declare cursor_name no scroll cursor with hold for select 1; -- declare a cursor
  select * from pg_cursors; -- verify that the cursor now exists in the connection
  ```

3. simulate an unexpected exit
  ```bash
  # run in another console
  make kill-psql
  ```

4. re-connect and verify that the cursor persists
-
  ```bash
  make session
  ```
-
  ```sql
  select * from pg_cursors;
  ```

## Clean Up

```bash
make down
```
