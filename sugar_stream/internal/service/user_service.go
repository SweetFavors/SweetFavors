package service

import (
	"log"
	"sugar_stream/internal/entities"
	"sugar_stream/internal/repository"
)

type userService struct {
	userRepo repository.UserRepository
}

func NewUserService(userRepo repository.UserRepository) userService {
	return userService{userRepo: userRepo}
}

func (s userService) GetUsers() ([]entities.User, error) {
	users, err := s.userRepo.GetAllUser()
	if err != nil {
		log.Println(err)
		return nil, err
	}

	userResponses := []entities.User{}
	for _, user := range users {
		userResponse := entities.User{
			UserID:       user.UserID,
			Username:     user.Username,
			Password:     user.Password,
			Email:        user.Email,
			Firstname:    user.Firstname,
			Lastname:     user.Lastname,
			PhoneNum:     user.PhoneNum,
			UserPic:      user.UserPic,
			PromptPayAcc: user.PromptPayAcc,
			PromptPayQR:  user.PromptPayQR,
		}
		userResponses = append(userResponses, userResponse)
	}
	return userResponses, nil
}

func (s userService) GetUser(userid int) (*entities.User, error) {
	user, err := s.userRepo.GetUserById(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	userResponse := entities.User{
		UserID:       user.UserID,
		Username:     user.Username,
		Password:     user.Password,
		Email:        user.Email,
		Firstname:    user.Firstname,
		Lastname:     user.Lastname,
		PhoneNum:     user.PhoneNum,
		UserPic:      user.UserPic,
		PromptPayAcc: user.PromptPayAcc,
		PromptPayQR:  user.PromptPayQR,
	}
	return &userResponse, nil
}

////////////////////////////////////////////////////////////////////////////////////

func (s userService) GetProfileOfCurrentUser(userid int) (*entities.User, error) {
	user, err := s.userRepo.GetProfileOfCurrentUserId(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	userResponse := entities.User{
		UserID:       user.UserID,
		Username:     user.Username,
		Password:     user.Password,
		Email:        user.Email,
		Firstname:    user.Firstname,
		Lastname:     user.Lastname,
		PhoneNum:     user.PhoneNum,
		UserPic:      user.UserPic,
		PromptPayAcc: user.PromptPayAcc,
		PromptPayQR:  user.PromptPayQR,
	}
	return &userResponse, nil
}

func (s userService) GetSearchFriend(excludeUserID int) ([]entities.User, error) {
	users, err := s.userRepo.GetAllSearchFriend(excludeUserID)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	userResponses := []entities.User{}
	for _, user := range users {
		userResponse := entities.User{
			UserID:       user.UserID,
			Username:     user.Username,
			Password:     user.Password,
			Email:        user.Email,
			Firstname:    user.Firstname,
			Lastname:     user.Lastname,
			PhoneNum:     user.PhoneNum,
			UserPic:      user.UserPic,
			PromptPayAcc: user.PromptPayAcc,
			PromptPayQR:  user.PromptPayQR,
		}
		userResponses = append(userResponses, userResponse)
	}
	return userResponses, nil
}

func (s userService) GetDonateInfo(userid int) (*entities.User, error) {
	user, err := s.userRepo.GetDonateInfoByUserId(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	userResponse := entities.User{
		UserID:       user.UserID,
		Username:     user.Username,
		Password:     user.Password,
		Email:        user.Email,
		Firstname:    user.Firstname,
		Lastname:     user.Lastname,
		PhoneNum:     user.PhoneNum,
		UserPic:      user.UserPic,
		PromptPayAcc: user.PromptPayAcc,
		PromptPayQR:  user.PromptPayQR,
	}
	return &userResponse, nil
}
