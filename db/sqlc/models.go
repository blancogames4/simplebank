// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0

package simplebank

import (
	"database/sql"
	"time"
)

type Account struct {
	ID          int64
	Owner       string
	Balance     int64
	Currency    string
	CreatedAt   time.Time
	CountryCode sql.NullInt32
}

type Entry struct {
	ID        int64
	AccountID int64
	Amount    int64
	CreatedAt time.Time
}

type Transfer struct {
	ID            int64
	FromAccountID int64
	ToAccountID   int64
	Amount        int64
	CreatedAt     time.Time
}
