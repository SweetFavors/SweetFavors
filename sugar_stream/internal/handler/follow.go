package handler

import (
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
			UserID: follow.UserID,
			FollowingID: follow.FollowingID,
		})
	}
	return c.JSON(followsResponse)
}



func (h *followHandler) GetFollowing(c *fiber.Ctx) error {
    // userIDExtract, err := 1, nil
    // if err != nil {
    //     return err
    // }
	userIDExtract := 1

    follow, err := h.followSer.GetFollowing(userIDExtract)
    if err != nil {
        return err
    }

    followResponse := dtos.FollowingResponse{
		UserID: follow.UserID,
		FollowingID: follow.FollowingID,
    }

    return c.JSON(followResponse)
}



func (h *followHandler) GetFollowers(c *fiber.Ctx) error {
    // userIDExtract, err := 1, nil
    // if err != nil {
    //     return err
    // }
	userIDExtract := 1

    follow, err := h.followSer.GetFollowers(userIDExtract)
    if err != nil {
        return err
    }

    followResponse := dtos.FollowingResponse{
		UserID: follow.UserID,
		FollowingID: follow.FollowingID,
    }

    return c.JSON(followResponse)
}




