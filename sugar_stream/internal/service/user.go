package service

import "sugar_stream/internal/entities"

type UserService interface {
	GetUsers() ([]entities.User, error)
	GetUser(int) (*entities.User, error)
	////////////////////////////////////////////////////////////////////
	GetProfileOfCurrentUser(int) (*entities.User, error)
	GetSearchFriend(int) ([]entities.User, error)
	GetDonateInfo(int) (*entities.User, error)

	GetEditUserProfile(int) (*entities.User, error)
}
