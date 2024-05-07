package service

import (
	"log"
	"sugar_stream/internal/entities"
	"sugar_stream/internal/repository"
)

type followService struct {
	followRepo repository.FollowRepository
}

func NewFollowService(followRepo repository.FollowRepository) followService {
	return followService{followRepo: followRepo}
}

func (s followService) GetFollows() ([]entities.Follow, error) {
	follows, err := s.followRepo.GetAllFollow()
	if err != nil {
		log.Println(err)
		return nil, err
	}

	followResponses := []entities.Follow{}
	for _, follow := range follows {
		userResponse := entities.Follow{
			UserID:      follow.UserID,
			FollowingID: follow.FollowingID,
		}
		followResponses = append(followResponses, userResponse)
	}
	return followResponses, nil
}

func (s followService) GetFollowing(userid int) ([]entities.Follow, error) {
	follows, err := s.followRepo.GetUserIDFollowing(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	followResponses := []entities.Follow{}
	for _, follow := range follows {
		userResponse := entities.Follow{
			UserID:      follow.UserID,
			FollowingID: follow.FollowingID,
		}
		followResponses = append(followResponses, userResponse)
	}
	return followResponses, nil
}

func (s followService) GetFollowers(userid int) ([]entities.Follow, error) {
	follows, err := s.followRepo.GetUserIDFollowers(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	followResponses := []entities.Follow{}
	for _, follow := range follows {
		userResponse := entities.Follow{
			UserID:      follow.UserID,
			FollowingID: follow.FollowingID,
		}
		followResponses = append(followResponses, userResponse)
	}
	return followResponses, nil
}

//////////////////////////////////////////////////////////////////////////////////////////

func (s followService) GetFollowingOfCurrentUser(userid int) ([]entities.Follow, error) {
	follows, err := s.followRepo.GetFollowingOfCurrentUserId(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	followResponses := []entities.Follow{}
	for _, follow := range follows {
		userResponse := entities.Follow{
			UserID:            follow.UserID,
			FollowingID:       follow.FollowingID,
			FollowingUsername: follow.FollowingUsername,
			FollowingUserPic:  follow.FollowingUserPic,
		}
		followResponses = append(followResponses, userResponse)
	}
	return followResponses, nil
}

func (s followService) GetFollowersOfCurrentUser(userid int) ([]entities.Follow, error) {
	follows, err := s.followRepo.GetFollowersOfCurrentUserId(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	followResponses := []entities.Follow{}
	for _, follow := range follows {
		userResponse := entities.Follow{
			UserID:           follow.UserID,
			FollowingID:      follow.FollowingID,
			FollowerUsername: follow.FollowerUsername,
			FollowerUserPic:  follow.FollowerUserPic,
		}
		followResponses = append(followResponses, userResponse)
	}
	return followResponses, nil
}
