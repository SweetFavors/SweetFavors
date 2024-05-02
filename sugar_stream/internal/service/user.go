package service

import "sugar_stream/internal/entities"

type UserService interface {
	GetUsers() ([]entities.User, error)
	GetUser(int) (*entities.User, error)
}