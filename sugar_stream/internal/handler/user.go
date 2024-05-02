package handler

import (
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
			UserID: user.UserID,
			Username: user.Username,
			Password: user.Password,
			Email: user.Email,
			Firstname: user.Firstname,
			Lastname: user.Lastname,
			PhoneNum: user.PhoneNum,
			UserPic: user.UserPic,
			PromptPayAcc: user.PromptPayAcc,
			PromptPayQR: user.PromptPayQR,
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
        UserID:    user.UserID,
        Username:  user.Username,
        Password:  user.Password,
        Email:     user.Email,
        Firstname: user.Firstname,
        Lastname:  user.Lastname,
        PhoneNum:  user.PhoneNum,
        UserPic:   user.UserPic,
		PromptPayAcc: user.PromptPayAcc,
		PromptPayQR: user.PromptPayQR,
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
        UserID:    user.UserID,
        Username:  user.Username,
        Firstname: user.Firstname,
        Lastname:  user.Lastname,
        UserPic:   user.UserPic,
		PromptPayAcc: user.PromptPayAcc,
		PromptPayQR: user.PromptPayQR,
    }

    return c.JSON(userResponse)
}


