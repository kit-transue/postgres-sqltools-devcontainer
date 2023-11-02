# PostgreSQL in a DevContainer

PostgreSQL can be used in a devcontainer--which can be run with Docker,
a Docker-compatible container host, or with GitHub Codespaces in the
cloud with a free GitHub account.

This repository contains a .devcontainer folder to describe this setup.
It specifies:

- a PostgreSQL database container
- a "postgres" user and database created on the database server
- a Python "App" container with PostgreSQL command line tools
- VSCode SQLTools extension
- settings to connect CLI and SQLTools to the database


## Server, User, and Connection

The setup includes *two* containers. The main one you will interact
with is an "app" client environment that has Python and PostgreSQL
client applications installed. The second is a "db" environment that
runs the PostgreSQL server.


### Connection details

- host: localhost (network socket; not a Unix Domain Socket)
- port: 5432
- user: postgres
- password: postgres

These should already be set for you:

- in the environment for the shell tools (psql, etc.)
- in VSCode settings for the VSCode SQLTools database connector

Each of the files in .devcontainer contribute to this setup.


### Database

You will be working as the "postgres" super-user. This user has
permissions to do anything in the database--including operations that
might disrupt the internal operations of the database. You can always
rebuild the image to return to a known good (and empty!) state.


## Launching

### VSCode in web browser

This uses GitHub Codespaces.

From the GitHub web page: Fork this repository so you have a GitHub
copy (if you are not already a collaborator), then make or start a
Codespace from the Code menu on the repository.


### Local VSCode with GitHub Codespace

This allows you to use a local version of VSCode for good
responsiveness in the editor and maximum familiarity with your
operating system's hot keys, but still leverages Codespaces to run the
container.

#### Setup

- fork on GitHub
- start VSCode locally
- install the GitHub Codespace extension

#### Usage

- from the VSCode command menu (ctrl-shift-P or command-shift-P), type
  "codespaces" to find commands related to this extension.
- select a codespace for the repository of interest:
  - if you need a new codespace, choose "Create New Codespace")
  - if you have an existing codespace for the project, select
    "Codespaces: Open Codespace in New Window".

A new window will open with the local VSCode, but all files
(*including the work tree*) are remote on the container.


### Local VSCode, Local Container

Install/configure a local Docker-compatible containerd hosting
environment.

Install the VSCode DevContainer extension from Microsoft.

When you open a repo with a .devcontainer folder, VSCode should prompt
you to reopen in a container. Accept this.


### Local VSCode and PostgreSQL (not using a container)

You may decline the "re-open in container" offer and just work
locally. Your Terminal scripts will run against whatever PostgreSQL
you have configured.

You may want to install the SQLTools and SQLTools/Postgres Driver
VSCode extensions by Matheus Teixeira and configure it to connect
to your database.


## Working

### From the Terminal

The Postgres commands and the environment should be ready to go.

```
psql --list
```

Note: this is a Unix bash environment.


### Using SQLTools

The SQLTools should have its own icon on the left dock (the cylinder
that represents long-term storage on disk drives).

When you select the SQLTools explorer, you should see the connection
to the database in the lower left corner.

Any SQL file should have a "play" option; play sends the file (or
selection) to the database. Results are returned in a table browser in
a new tab.

If the tools ask you to connect, there should be a single connection
offered. Accept that.


## Lifecycle

You are responsible for adding and populating tables. A basic
reset migration is included.

### Migration

"Migration" describes the pattern for changing the database schema
over time.

The base environment does not have much migration support, but includes a
"migrate-zero.sh" script that will drops/recreates the default database.


## Resetting

Most of the time, the dropdb/createdb in migrate-zero.sh should be
sufficient to return your database to its original state. If something
bigger seems wrong, you can reset your container.

In GitHub: "rebuild container" does *not* reset the database state.
You must do a "full rebuild" to return the database to its original,
empty state.

(If you are using local devcontainers, you need remove the persistent
volume overlays to replace the database state.)
