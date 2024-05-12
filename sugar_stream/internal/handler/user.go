package handler

import (
	"strconv"
	"sugar_stream/internal/dtos"
	"sugar_stream/internal/service"

	"github.com/gofiber/fiber/v2"
)

type userHandler struct {
	userSer service.UserService
}

func NewUserHandler(userSer service.UserService) userHandler {
	return userHandler{userSer: userSer}
}

func (h *userHandler) GetUsers(c *fiber.Ctx) error {
	usersResponse := make([]dtos.UserResponse, 0)

	users, err := h.userSer.GetUsers()
	if err != nil {
		return err
	}

	for _, user := range users {
		usersResponse = append(usersResponse, dtos.UserResponse{
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
		})
	}
	return c.JSON(usersResponse)
}

func (h *userHandler) GetUser(c *fiber.Ctx) error {
	// userIDExtract, err := 1, nil
	// if err != nil {
	//     return err
	// }
	userIDExtract := 1

	user, err := h.userSer.GetUser(userIDExtract)
	if err != nil {
		return err
	}

	userResponse := dtos.UserIDInfoResponse{
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

	return c.JSON(userResponse)
}

func (h *userHandler) GetUserCurrent(c *fiber.Ctx) error {
	// userIDExtract, err := 1, nil
	// if err != nil {
	//     return err
	// }
	userIDExtract := 2

	user, err := h.userSer.GetUser(userIDExtract)
	if err != nil {
		return err
	}

	userResponse := dtos.UserCurrentResponse{
		UserID:       user.UserID,
		Username:     user.Username,
		Firstname:    user.Firstname,
		Lastname:     user.Lastname,
		UserPic:      user.UserPic,
		PromptPayAcc: user.PromptPayAcc,
		PromptPayQR:  user.PromptPayQR,
	}

	return c.JSON(userResponse)
}

/////////////////////////////////////////////////////////////////////////

func (h *userHandler) GetProfileOfCurrentUser(c *fiber.Ctx) error {
	userID := c.Params("userID")

	userIDReceive, err := strconv.Atoi(userID)
	if err != nil {
		return err
	}

	user, err := h.userSer.GetProfileOfCurrentUser(userIDReceive)
	if err != nil {
		return err
	}

	userResponse := dtos.ProfileOfCurrentUserResponse{
		UserID:    user.UserID,
		Username:  user.Username,
		Email:     user.Email,
		Firstname: user.Firstname,
		Lastname:  user.Lastname,
		PhoneNum:  user.PhoneNum,
		UserPic:   user.UserPic,
	}

	return c.JSON(userResponse)
}

func (h *userHandler) GetSearchFriend(c *fiber.Ctx) error {
	// userIDExtract, err := 1, nil
	// if err != nil {
	//     return err
	// }
	userIDExtract := 1

	usersResponse := make([]dtos.SearchFriendResponse, 0)

	users, err := h.userSer.GetSearchFriend(userIDExtract)
	if err != nil {
		return err
	}

	for _, user := range users {
		usersResponse = append(usersResponse, dtos.SearchFriendResponse{
			UserID:   user.UserID,
			Username: user.Username,
			UserPic:  user.UserPic,
		})
	}
	return c.JSON(usersResponse)
}

func (h *userHandler) GetDonateInfo(c *fiber.Ctx) error {
	userID := c.Params("userID")

	userIDReceive, err := strconv.Atoi(userID)
	if err != nil {
		return err
	}

	user, err := h.userSer.GetProfileOfCurrentUser(userIDReceive)
	if err != nil {
		return err
	}

	userResponse := dtos.DonateInfoResponse{
		UserID:       user.UserID,
		Username:     user.Username,
		Firstname:    user.Firstname,
		Lastname:     user.Lastname,
		PromptPayAcc: user.PromptPayAcc,
		PromptPayQR:  user.PromptPayQR,
	}

	return c.JSON(userResponse)
}

func (h *userHandler) GetEditUserProfile(c *fiber.Ctx) error {
	userID := c.Params("userID")

	userIDReceive, err := strconv.Atoi(userID)
	if err != nil {
		return err
	}

	user, err := h.userSer.GetEditUserProfile(userIDReceive)
	if err != nil {
		return err
	}

	userResponse := dtos.EditUserProfileResponse{
		UserID:    user.UserID,
		Username:  user.Username,
		Email:     user.Email,
		Firstname: user.Firstname,
		Lastname:  user.Lastname,
		PhoneNum:  user.PhoneNum,
	}

	return c.JSON(userResponse)
}

func (h *userHandler) UpdateEditUserProfile(c *fiber.Ctx) error {
	userID, err := strconv.Atoi(c.Params("UserID"))
	if err != nil {
		return err
	}

	var req dtos.EditUserProfileRequest
	if err := c.BodyParser(&req); err != nil {
		return err
	}

	user, err := h.userSer.UpdateEditUserProfile(userID, req)
	if err != nil {
		return err
	}

	userResponse := dtos.EditUserProfileRequest{
		Username:  user.Username,
		Email:     user.Email,
		Firstname: user.Firstname,
		Lastname:  user.Lastname,
		PhoneNum:  user.PhoneNum,
	}

	return c.JSON(userResponse)
}
