package repository

import "sugar_stream/internal/entities"

type UserRepository interface {
	GetAllUser() ([]entities.User, error)
	GetUserById(int) (*entities.User, error)
	////////////////////////////////////////////////////////////////////
	GetProfileOfCurrentUserId(int) (*entities.User, error)
	GetAllSearchFriend(int) ([]entities.User, error)
	GetDonateInfoByUserId(int) (*entities.User, error)
}
