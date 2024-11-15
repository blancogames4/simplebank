
-- name: CreateAccount :one
INSERT INTO accounts (owner, balance, currency) VALUES ($1, $2, $3) RETURNING *;

-- name: GetAccount :one
SELECT * FROM accounts WHERE id = $1 LIMIT 1;

-- name: GetAccountForUpdate :one
SELECT * FROM accounts WHERE id = $1 LIMIT 1 FOR NO KEY UPDATE;

-- name: GetAccounts :many
SELECT * FROM accounts WHERE owner=$1 ORDER BY id LIMIT $2 OFFSET $3;

-- name: UpdateAccount :one
UPDATE accounts SET balance = $2 WHERE id = $1 RETURNING *;

-- name: AddAccountBalance :one
UPDATE accounts SET balance = balance + sqlc.arg(amount) WHERE id = sqlc.arg(id) RETURNING *;

-- name: DeleteAccount :exec
DELETE FROM accounts WHERE id = $1;

-- name: CreateTransfer :one
INSERT INTO transfers (from_account_id, to_account_id, amount) VALUES ($1, $2, $3) RETURNING *;

-- name: GetTransfer :one
SELECT * FROM transfers WHERE id=$1;

-- name: GetTransfers :many
SELECT * FROM transfers WHERE from_account_id = $1 OR to_account_id = $1 LIMIT $1 OFFSET $2;

-- name: GetTransfersBetweenAccounts :many
SELECT * FROM transfers WHERE from_account_id = $1 AND to_account_id = $2 LIMIT $1 OFFSET $2;

-- name: GetRecentTransfers :many
SELECT * FROM transfers ORDER BY created_at DESC LIMIT $1 OFFSET $2;

-- name: UpdateTransfer :exec
UPDATE transfers set amount =$2 WHERE from_account_id = $1 AND to_account_id = $3;

-- name: DeleteTransfer :exec
DELETE FROM transfers WHERE from_account_id = $1 OR to_account_id = $1;

-- name: CreateEntry :one
INSERT INTO entries (account_id, amount) VALUES ($1, $2) RETURNING *;

-- name: GetEntry :one
SELECT * FROM entries WHERE id = $1;

-- name: GetEntries :one
SELECT * FROM entries WHERE account_id=$1 ORDER BY created_at LIMIT $1 OFFSET $2;

-- name: UpdateEntry :exec
UPDATE entries SET amount = $2 WHERE id = $1 RETURNING *;

-- name: DeleteEntry :exec
DELETE FROM entries WHERE id = $1 RETURNING *;