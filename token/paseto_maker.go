package token

import (
	"fmt"
	"time"

	"github.com/aead/chacha20poly1305"
	"github.com/o1egl/paseto"
)

type PasetoMaker struct {
	paseto        *paseto.V2
	symmetrictKey []byte
}

// VeryfyToken implements Maker.
func (maker *PasetoMaker) VeryfyToken(token string) (*Payload, error) {
	payload := &Payload{}

	err := maker.paseto.Decrypt(token, maker.symmetrictKey, payload, nil)
	if err != nil {
		return nil, err
	}

	err = payload.Valid()
	if err != nil {
		return nil, err
	}
	return payload, nil
}

func NewPasetoMaker(simmetricKey string) (Maker, error) {
	if len(simmetricKey) != chacha20poly1305.KeySize {
		return nil, fmt.Errorf("invlaid key size: must be exactly %d characters", chacha20poly1305.KeySize)
	}

	maker := &PasetoMaker{
		paseto:        paseto.NewV2(),
		symmetrictKey: []byte(simmetricKey),
	}
	return maker, nil
}

func (maker *PasetoMaker) CreateToken(username string, duration time.Duration) (string, error) {
	payload, err := NewPayload(username, duration)
	if err != nil {
		return "", err
	}

	return maker.paseto.Encrypt(maker.symmetrictKey, payload, nil)
}
