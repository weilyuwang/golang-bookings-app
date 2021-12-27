package repository

import "github.com/weilyuwang/golang-bookings-app/internal/models"

type DatabaseRepo interface {
	AllUsers() bool

	InsertReservation(res models.Reservation) error
}
