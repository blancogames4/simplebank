postgres:
	docker run --name some-postgres --network bank-network -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres

createdb: 
	docker exec -it some-postgres createdb --username=postgres --owner=postgres simple_bank

dropdb: 
	docker exe -it some-postgres dropdb --username=postgres --owner=postgres simple_bank

migrateup:
	migrate -source file://./db/migration -database postgres://postgres:mysecretpassword@localhost:5432/simple_bank?sslmode=disable -verbose up

migrateup1:
	migrate -source file://./db/migration -database postgres://postgres:mysecretpassword@localhost:5432/simple_bank?sslmode=disable -verbose up 1

migratedown:
	migrate -source file://./db/migration -database postgres://postgres:mysecretpassword@localhost:5432/simple_bank?sslmode=disable -verbose down

migratedown1:
	migrate -source file://./db/migration -database postgres://postgres:mysecretpassword@localhost:5432/simple_bank?sslmode=disable -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./db/sqlc ./api

server:
	go run main.go

mock:
	mockgen -destination db/mock/store.go -package mockdb github.com/blancogames4/simplebank/db/sqlc Store
	
.PHONY:
	postgres createdb dropdb migrateup migratedown sqlc test server mock migrateup1 migratedown1