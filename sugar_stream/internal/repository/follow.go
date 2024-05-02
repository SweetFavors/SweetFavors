package repository

import "sugar_stream/internal/entities"

type FollowRepository interface {
	GetAllFollow() ([]entities.Follow, error)

	GetUserIDFollowing(int) (*entities.Follow, error)
	GetUserIDFollowers(int) (*entities.Follow, error)
}