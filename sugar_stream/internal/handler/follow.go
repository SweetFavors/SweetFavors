package handler

import (
	"strconv"
	"sugar_stream/internal/dtos"
	"sugar_stream/internal/service"

	"github.com/gofiber/fiber/v2"
)

type followHandler struct {
	followSer service.FollowService
}

func NewFollowHandler(followSer service.FollowService) followHandler {
	return followHandler{followSer: followSer}
}

func (h *followHandler) GetFollows(c *fiber.Ctx) error {
	followsResponse := make([]dtos.FollowResponse, 0)

	follows, err := h.followSer.GetFollows()
	if err != nil {
		return err
	}

	for _, follow := range follows {
		followsResponse = append(followsResponse, dtos.FollowResponse{
			UserID:      follow.UserID,
			FollowingID: follow.FollowingID,
		})
	}
	return c.JSON(followsResponse)
}

func (h *followHandler) GetFollowing(c *fiber.Ctx) error {
	followsResponse := make([]dtos.FollowResponse, 0)

	// userIDExtract, err := 1, nil
	// if err != nil {
	//     return err
	// }
	userIDExtract := 1

	follows, err := h.followSer.GetFollowing(userIDExtract)
	if err != nil {
		return err
	}

	for _, follow := range follows {
		followsResponse = append(followsResponse, dtos.FollowResponse{
			UserID:      follow.UserID,
			FollowingID: follow.FollowingID,
		})
	}
	return c.JSON(followsResponse)
}

func (h *followHandler) GetFollowers(c *fiber.Ctx) error {
	followsResponse := make([]dtos.FollowResponse, 0)

	// userIDExtract, err := 1, nil
	// if err != nil {
	//     return err
	// }
	userIDExtract := 1

	follows, err := h.followSer.GetFollowers(userIDExtract)
	if err != nil {
		return err
	}

	for _, follow := range follows {
		followsResponse = append(followsResponse, dtos.FollowResponse{
			UserID:      follow.UserID,
			FollowingID: follow.FollowingID,
		})
	}
	return c.JSON(followsResponse)
}

////////////////////////////////////////////////////////////////////////////////////////

func (h *followHandler) GetFollowingOfCurrentUser(c *fiber.Ctx) error {
	followsResponse := make([]dtos.FollowingOfCurrentUserResponse, 0)

	// userIDExtract, err := 1, nil
	// if err != nil {
	//     return err
	// }
	userIDExtract := 1

	follows, err := h.followSer.GetFollowingOfCurrentUser(userIDExtract)
	if err != nil {
		return err
	}

	for _, follow := range follows {
		followsResponse = append(followsResponse, dtos.FollowingOfCurrentUserResponse{
			UserID:            follow.UserID,
			FollowingID:       follow.FollowingID,
			FollowingUsername: follow.FollowingUsername,
			FollowingUserPic:  follow.FollowingUserPic,
		})
	}
	return c.JSON(followsResponse)
}

func (h *followHandler) GetFollowersOfCurrentUser(c *fiber.Ctx) error {
	followsResponse := make([]dtos.FollowersOfCurrentUserResponse, 0)

	// userIDExtract, err := 1, nil
	// if err != nil {
	//     return err
	// }
	userIDExtract := 1

	follows, err := h.followSer.GetFollowersOfCurrentUser(userIDExtract)
	if err != nil {
		return err
	}

	for _, follow := range follows {
		followsResponse = append(followsResponse, dtos.FollowersOfCurrentUserResponse{
			UserID:           follow.UserID,
			FollowingID:      follow.FollowingID,
			FollowerUsername: follow.FollowerUsername,
			FollowerUserPic:  follow.FollowerUserPic,
		})
	}
	return c.JSON(followsResponse)
}

func (h *followHandler) GetCheckFollowingYet(c *fiber.Ctx) error {

	currentUserID, err := strconv.Atoi(c.Params("CurrentUserID"))
	if err != nil {
		return err
	}

	friendUserID, err := strconv.Atoi(c.Params("FriendUserID"))
	if err != nil {
		return err
	}

	follow, err := h.followSer.GetCheckFollowingYet(currentUserID, friendUserID)
	if err != nil {
		return err
	}

	followResponse := dtos.CheckFollowingYetResponse{
		UserID:      follow.UserID,
		FollowingID: follow.FollowingID,
	}

	return c.JSON(followResponse)
}

func (h *followHandler) PostAddToFollowing(c *fiber.Ctx) error {
	currentUserID, err := strconv.Atoi(c.Params("CurrentUserID"))
	if err != nil {
		return err
	}

	friendUserID, err := strconv.Atoi(c.Params("FriendUserID"))
	if err != nil {
		return err
	}

	err = h.followSer.AddToFollowing(currentUserID, friendUserID)
	if err != nil {
		return err
	}

	return c.SendStatus(fiber.StatusCreated)
}

func (h *followHandler) DeleteUnFollowing(c *fiber.Ctx) error {
	currentUserID, err := strconv.Atoi(c.Params("CurrentUserID"))
	if err != nil {
		return err
	}

	friendUserID, err := strconv.Atoi(c.Params("FriendUserID"))
	if err != nil {
		return err
	}

	err = h.followSer.UnFollowing(currentUserID, friendUserID)
	if err != nil {
		return err
	}

	return c.SendStatus(fiber.StatusOK)
}
