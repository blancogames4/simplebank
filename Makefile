postgres:
	docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres

createdb: 
	docker exec -it some-postgres createdb --username=postgres --owner=postgres simple_bank

dropdb: 
	docker exe -it some-postgres dropdb --username=postgres --owner=postgres simple_bank

migrateup:
	migrate -source file://C:/learning/simplebank/db/migration -database postgres://postgres:mysecretpassword@localhost:5432/simple_bank?sslmode=disable -verbose up

migratedown:
	migrate -source file://C:/learning/simplebank/db/migration -database postgres://postgres:mysecretpassword@localhost:5432/simple_bank?sslmode=disable -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./db/sqlc
	
.PHONY:
	postgres createdb dropdb migrateup migratedown