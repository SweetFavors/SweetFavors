package repository

import "sugar_stream/internal/entities"

type UserRepository interface {
	GetAllUser() ([]entities.User, error)
	GetUserById(int) (*entities.User, error)
	////////////////////////////////////////////////////////////////////
	GetProfileOfCurrentUserId(int) (*entities.User, error)
	GetAllSearchFriend(int, string) ([]entities.User, error)

	GetEditUserProfile(int) (*entities.User, error)

	UpdateEditUserProfile(user *entities.User) error

	CreateUser(user *entities.User) error
	GetUserByUsername(username string) (*entities.User, error)
}
