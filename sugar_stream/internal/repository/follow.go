package repository

import "sugar_stream/internal/entities"

type FollowRepository interface {
	GetAllFollow() ([]entities.Follow, error)

	GetUserIDFollowing(int) ([]entities.Follow, error)
	GetUserIDFollowers(int) ([]entities.Follow, error)
	////////////////////////////////////////////////////
	GetFollowingOfCurrentUserId(int) ([]entities.Follow, error)
	GetFollowersOfCurrentUserId(int) ([]entities.Follow, error)
	GetCheckFollowingYetByData(int, int) (*entities.Follow, error)

	PostAddToFollowing(follow *entities.Follow) error
	DeleteUnFollowing(follow *entities.Follow) error
}
