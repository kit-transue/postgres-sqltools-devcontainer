# migreate-zero.sh
# Return default database to its original empty state
# (simply by dropping and recreating it).

# "Migrate" is the database pattern for evolving a database
# schema. Migrating back to "zero" is returning to a new state.

dropdb
createdb
