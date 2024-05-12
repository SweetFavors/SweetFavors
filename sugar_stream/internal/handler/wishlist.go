package handler

import (
	"strconv"
	"sugar_stream/internal/dtos"
	"sugar_stream/internal/service"

	"github.com/gofiber/fiber/v2"
)

type wishlistHandler struct {
	wishlistSer service.WishlistService
}

func NewWishlistHandler(wishlistSer service.WishlistService) wishlistHandler {
	return wishlistHandler{wishlistSer: wishlistSer}
}

func (h *wishlistHandler) GetWishlists(c *fiber.Ctx) error {
	wishlistsResponse := make([]dtos.WishlistResponse, 0)

	wishlists, err := h.wishlistSer.GetWishlists()
	if err != nil {
		return err
	}

	for _, wishlist := range wishlists {
		wishlistsResponse = append(wishlistsResponse, dtos.WishlistResponse{
			WishlistID:      wishlist.WishlistID,
			UserID:          wishlist.UserID,
			Itemname:        wishlist.Itemname,
			Quantity:        wishlist.Quantity,
			Price:           wishlist.Price,
			LinkURL:         wishlist.LinkURL,
			ItemPic:         wishlist.ItemPic,
			AlreadyBought:   wishlist.AlreadyBought,
			GrantedByUserId: wishlist.GrantedByUserId,
		})
	}
	return c.JSON(wishlistsResponse)
}

func (h *wishlistHandler) GetWishlistsOfUser(c *fiber.Ctx) error {

	// userIDExtract, err := 1, nil
	// if err != nil {
	//     return err
	// }
	userIDExtract := 1

	wishlistsResponse := make([]dtos.WishlistsUserCurrentResponse, 0)
	wishlists, err := h.wishlistSer.GetWishlistsOfUser(userIDExtract)
	if err != nil {
		return err
	}

	for _, wishlist := range wishlists {
		wishlistsResponse = append(wishlistsResponse, dtos.WishlistsUserCurrentResponse{
			WishlistID:      wishlist.WishlistID,
			UserID:          wishlist.UserID,
			Itemname:        wishlist.Itemname,
			Quantity:        wishlist.Quantity,
			Price:           wishlist.Price,
			LinkURL:         wishlist.LinkURL,
			ItemPic:         wishlist.ItemPic,
			AlreadyBought:   wishlist.AlreadyBought,
			GrantedByUserId: wishlist.GrantedByUserId,
		})
	}
	return c.JSON(wishlistsResponse)
}

func (h *wishlistHandler) GetWishlist(c *fiber.Ctx) error {
	// userIDExtract, err := 1, nil
	// if err != nil {
	//     return err
	// }
	wishlistIDReceive := 3

	wishlist, err := h.wishlistSer.GetWishlist(wishlistIDReceive)
	if err != nil {
		return err
	}

	wishlistResponse := dtos.WishlistResponse{
		WishlistID:      wishlist.WishlistID,
		UserID:          wishlist.UserID,
		Itemname:        wishlist.Itemname,
		Quantity:        wishlist.Quantity,
		Price:           wishlist.Price,
		LinkURL:         wishlist.LinkURL,
		ItemPic:         wishlist.ItemPic,
		AlreadyBought:   wishlist.AlreadyBought,
		GrantedByUserId: wishlist.GrantedByUserId,
	}

	return c.JSON(wishlistResponse)
}

//****************************************************************************

func (h *wishlistHandler) GetWishlistsOfCurrentUser(c *fiber.Ctx) error {
	userIDExtract := 1 // Assuming you'll get the userID from the request later

	wishlists, err := h.wishlistSer.GetWishlistsOfCurrentUser(userIDExtract)
	if err != nil {
		return err
	}

	wishlistsResponse := make([]dtos.WishlistsOfCurrentUserResponse, 0)
	for _, wishlist := range wishlists {
		wishlistsResponse = append(wishlistsResponse, dtos.WishlistsOfCurrentUserResponse{
			WishlistID:        wishlist.WishlistID,
			UserID:            wishlist.UserID,
			Itemname:          wishlist.Itemname,
			Quantity:          wishlist.Quantity,
			Price:             wishlist.Price,
			LinkURL:           wishlist.LinkURL,
			ItemPic:           wishlist.ItemPic,
			AlreadyBought:     wishlist.AlreadyBought,
			GrantedByUserId:   wishlist.GrantedByUserId,
			UsernameOfGranter: wishlist.UsernameOfGranter,
		})
	}
	return c.JSON(wishlistsResponse)
}

func (h *wishlistHandler) GetFriendsWishlists(c *fiber.Ctx) error {

	// userIDExtract, err := 1, nil
	// if err != nil {
	//     return err
	// }
	userIDExtract := 1

	wishlistsResponse := make([]dtos.FriendsWishlistsResponse, 0)
	wishlists, err := h.wishlistSer.GetFriendsWishlists(userIDExtract)
	if err != nil {
		return err
	}

	for _, wishlist := range wishlists {
		wishlistsResponse = append(wishlistsResponse, dtos.FriendsWishlistsResponse{
			WishlistID:         wishlist.WishlistID,
			UserID:             wishlist.UserID,
			Itemname:           wishlist.Itemname,
			Quantity:           wishlist.Quantity,
			Price:              wishlist.Price,
			LinkURL:            wishlist.LinkURL,
			ItemPic:            wishlist.ItemPic,
			AlreadyBought:      wishlist.AlreadyBought,
			GrantedByUserId:    wishlist.GrantedByUserId,
			UsernameOfWishlist: wishlist.UsernameOfWishlist,
			UserPicOfWishlist:  wishlist.UserPicOfWishlist,
		})
	}
	return c.JSON(wishlistsResponse)
}

func (h *wishlistHandler) GetWishlistDetails(c *fiber.Ctx) error {
	wishlistID := c.Params("wishlistID")

	wishlistIDReceive, err := strconv.Atoi(wishlistID)
	if err != nil {
		return err
	}

	wishlist, err := h.wishlistSer.GetWishlistDetails(wishlistIDReceive)
	if err != nil {
		return err
	}

	wishlistResponse := dtos.WishlistDetailsResponse{
		WishlistID:      wishlist.WishlistID,
		UserID:          wishlist.UserID,
		Itemname:        wishlist.Itemname,
		Quantity:        wishlist.Quantity,
		Price:           wishlist.Price,
		LinkURL:         wishlist.LinkURL,
		ItemPic:         wishlist.ItemPic,
		AlreadyBought:   wishlist.AlreadyBought,
		GrantedByUserId: wishlist.GrantedByUserId,
	}

	return c.JSON(wishlistResponse)
}

func (h *wishlistHandler) GetProfileFriendWishlists(c *fiber.Ctx) error {

	currentUserID, err := strconv.Atoi(c.Params("CurrentUserID"))
	if err != nil {
		return err
	}

	wishlistOwnerID, err := strconv.Atoi(c.Params("WishlistOwnerID"))
	if err != nil {
		return err
	}

	wishlistsResponse := make([]dtos.FriendsWishlistsResponse, 0)
	wishlists, err := h.wishlistSer.GetProfileFriendWishlists(currentUserID, wishlistOwnerID)
	if err != nil {
		return err
	}

	for _, wishlist := range wishlists {
		wishlistsResponse = append(wishlistsResponse, dtos.FriendsWishlistsResponse{
			WishlistID:         wishlist.WishlistID,
			UserID:             wishlist.UserID,
			Itemname:           wishlist.Itemname,
			Quantity:           wishlist.Quantity,
			Price:              wishlist.Price,
			LinkURL:            wishlist.LinkURL,
			ItemPic:            wishlist.ItemPic,
			AlreadyBought:      wishlist.AlreadyBought,
			GrantedByUserId:    wishlist.GrantedByUserId,
			UsernameOfWishlist: wishlist.UsernameOfWishlist,
			UserPicOfWishlist:  wishlist.UserPicOfWishlist,
		})
	}
	return c.JSON(wishlistsResponse)
}

func (h *wishlistHandler) UpdateGrantForFriend(c *fiber.Ctx) error {
	wishlistID, err := strconv.Atoi(c.Params("WishlistID"))
	if err != nil {
		return err
	}

	granterUserID, err := strconv.Atoi(c.Params("GranterUserID"))
	if err != nil {
		return err
	}

	_, err = h.wishlistSer.UpdateGrantForFriend(wishlistID, granterUserID)
	if err != nil {
		return err
	}

	return c.JSON(fiber.Map{"message": "UpdateGrantForFriend successfully"})
}

func (h *wishlistHandler) UpdateReceiverGotIt(c *fiber.Ctx) error {
	wishlistID, err := strconv.Atoi(c.Params("WishlistID"))
	if err != nil {
		return err
	}

	granterUserID, err := strconv.Atoi(c.Params("GranterUserID"))
	if err != nil {
		return err
	}

	_, err = h.wishlistSer.UpdateReceiverGotIt(wishlistID, granterUserID)
	if err != nil {
		return err
	}

	return c.JSON(fiber.Map{"message": "UpdateReceiverGotIt successfully"})
}

func (h *wishlistHandler) UpdateReceiverDidntGetIt(c *fiber.Ctx) error {
	wishlistID, err := strconv.Atoi(c.Params("WishlistID"))
	if err != nil {
		return err
	}

	granterUserID, err := strconv.Atoi(c.Params("GranterUserID"))
	if err != nil {
		return err
	}

	_, err = h.wishlistSer.UpdateReceiverDidntGetIt(wishlistID, granterUserID)
	if err != nil {
		return err
	}

	return c.JSON(fiber.Map{"message": "UpdateReceiverDidntGetIt successfully"})
}
