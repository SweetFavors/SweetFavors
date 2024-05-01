package service

import "sugar_stream/internal/entities"

type FollowService interface {
	GetFollows() ([]entities.Follow, error)

	GetFollowing(int) (*entities.Follow, error)
	GetFollowers(int) (*entities.Follow, error)
}