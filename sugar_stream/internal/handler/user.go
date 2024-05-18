package handler

import (
	"errors"
	"github.com/gofiber/fiber/v2"
	"strconv"
	"strings"
	"sugar_stream/internal/dtos"
	"sugar_stream/internal/service"
	"sugar_stream/internal/utils"
)

type userHandler struct {
	userSer   service.UserService
	jwtSecret string
	uploadSer service.UploadService
}

func NewUserHandler(userSer service.UserService, jwtSecret string, uploadSer service.UploadService) userHandler {
	return userHandler{userSer: userSer, jwtSecret: jwtSecret, uploadSer: uploadSer}
}

func (h *userHandler) GetUsers(c *fiber.Ctx) error {
	usersResponse := make([]dtos.UserDataResponse, 0)

	users, err := h.userSer.GetUsers()
	if err != nil {
		return err
	}

	for _, user := range users {
		usersResponse = append(usersResponse, dtos.UserDataResponse{
			UserID:    user.UserID,
			Username:  user.Username,
			Password:  user.Password,
			Email:     user.Email,
			Firstname: user.Firstname,
			Lastname:  user.Lastname,
			PhoneNum:  user.PhoneNum,
			UserPic:   user.UserPic,
		})
	}
	return c.JSON(usersResponse)
}

func (h *userHandler) GetUser(c *fiber.Ctx) error {
	// Extract the token from the request headers
	token := c.Get("Authorization")

	// Check if the token is empty
	if token == "" {
		return errors.New("token is missing")
	}

	// Extract the user ID from the token
	userIDExtract, err := utils.ExtractUserIDFromToken(strings.Replace(token, "Bearer ", "", 1), h.jwtSecret)
	if err != nil {
		return err
	}

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
	query := c.Query("query")
	if query == "" {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "query parameter is required"})
	}

	// Extract the token from the request headers
	token := c.Get("Authorization")

	// Check if the token is empty
	if token == "" {
		return errors.New("token is missing")
	}

	// Extract the user ID from the token
	userIDExtract, err := utils.ExtractUserIDFromToken(strings.Replace(token, "Bearer ", "", 1), h.jwtSecret)
	if err != nil {
		return err
	}

	usersResponse := make([]dtos.SearchFriendResponse, 0)

	users, err := h.userSer.GetSearchFriend(userIDExtract, query)
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

func (h *userHandler) Register(c *fiber.Ctx) error {
	var request dtos.RegisterRequest
	if err := c.BodyParser(&request); err != nil {
		return fiber.NewError(fiber.StatusBadRequest, err.Error())
	}

	// Check if a file is uploaded
	file, err := c.FormFile("file")
	if err != nil {
		return fiber.NewError(fiber.StatusBadRequest, "File not found")
	}

	// Call upload service to upload the file
	fileURL, err := h.uploadSer.UploadFile(file)
	if err != nil {
		return fiber.NewError(fiber.StatusInternalServerError, "Failed to upload file")
	}

	// Set the uploaded file URL in the registration request
	request.UserPic = fileURL

	// Check if user_pic field is empty or nil
	if request.UserPic == nil {
		return fiber.NewError(fiber.StatusBadRequest, "User picture is required")
	}

	response, err := h.userSer.Register(request)
	if err != nil {
		return fiber.NewError(fiber.StatusInternalServerError, err.Error())
	}

	return c.Status(fiber.StatusCreated).JSON(response)
}

func (h *userHandler) Login(c *fiber.Ctx) error {
	var request dtos.LoginRequest
	if err := c.BodyParser(&request); err != nil {
		return fiber.NewError(fiber.StatusBadRequest, err.Error())
	}

	if request.Username == nil || request.Password == nil {
		return fiber.NewError(fiber.StatusBadRequest, "Username and Password are required")
	}

	response, err := h.userSer.Login(request, h.jwtSecret)
	if err != nil {
		return fiber.NewError(fiber.StatusUnauthorized, err.Error())
	}

	return c.JSON(response)
}
