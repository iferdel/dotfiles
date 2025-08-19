# gopls
go install github.com/pressly/goose/v3/cmd/goose@latest
go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
# go sqlc docs https://docs.sqlc.dev/en/latest/tutorials/getting-started-postgresql.html
# when using uuid install go get github.com/google/uuid per project
# when connecting to psql, we need to add and import a postgres driver so our program knows how to talk to the database.
# go get github.com/lib/p --> import _ "github.com/lib/pq"
