// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0

package sqlc

import (
	"context"
)

type Querier interface {
	AddAccountBalance(ctx context.Context, arg AddAccountBalanceParams) (Account, error)
	CreateAccount(ctx context.Context, arg CreateAccountParams) (Account, error)
	CreateEntry(ctx context.Context, arg CreateEntryParams) (Entry, error)
	CreateTransfer(ctx context.Context, arg CreateTransferParams) (Transfer, error)
	CreateUser(ctx context.Context, arg CreateUserParams) (User, error)
	DeleteAccount(ctx context.Context, id int64) error
	DeleteEntry(ctx context.Context, id int64) error
	DeleteTransfer(ctx context.Context, fromAccountID int64) error
	GetAccount(ctx context.Context, id int64) (Account, error)
	GetAccountForUpdate(ctx context.Context, id int64) (Account, error)
	GetAccounts(ctx context.Context, arg GetAccountsParams) ([]Account, error)
	GetEntries(ctx context.Context, arg GetEntriesParams) (Entry, error)
	GetEntry(ctx context.Context, id int64) (Entry, error)
	GetRecentTransfers(ctx context.Context, arg GetRecentTransfersParams) ([]Transfer, error)
	GetTransfer(ctx context.Context, id int64) (Transfer, error)
	GetTransfers(ctx context.Context, arg GetTransfersParams) ([]Transfer, error)
	GetTransfersBetweenAccounts(ctx context.Context, arg GetTransfersBetweenAccountsParams) ([]Transfer, error)
	GetUsers(ctx context.Context, username string) (User, error)
	UpdateAccount(ctx context.Context, arg UpdateAccountParams) (Account, error)
	UpdateEntry(ctx context.Context, arg UpdateEntryParams) error
	UpdateTransfer(ctx context.Context, arg UpdateTransferParams) error
}

var _ Querier = (*Queries)(nil)
