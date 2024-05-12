package service

import "sugar_stream/internal/entities"

type FollowService interface {
	GetFollows() ([]entities.Follow, error)

	GetFollowing(int) ([]entities.Follow, error)
	GetFollowers(int) ([]entities.Follow, error)
	/////////////////////////////////////////////////
	GetFollowingOfCurrentUser(int) ([]entities.Follow, error)
	GetFollowersOfCurrentUser(int) ([]entities.Follow, error)
	GetCheckFollowingYet(int, int) (*entities.Follow, error)

	AddToFollowing(int, int) (*entities.Follow, error)
	UnFollowing(int, int) (*entities.Follow, error)
}
