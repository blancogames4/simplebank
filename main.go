package main

import (
	"database/sql"
	"log"

	"github.com/blancogames4/simplebank/api"
	db "github.com/blancogames4/simplebank/db/sqlc"
	"github.com/blancogames4/simplebank/db/util"
	_ "github.com/lib/pq"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config", err)
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server, err := api.NewServer(config, store)
	if err != nil {
		log.Fatal("cannot create server", err)
	}

	err = server.Start(config.ServiceAddress)
	if err != nil {
		log.Fatal("Cannot start Server:", err)
	}
}
