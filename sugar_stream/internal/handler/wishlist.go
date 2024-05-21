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

type wishlistHandler struct {
	wishlistSer service.WishlistService
	jwtSecret   string
	uploadSer   service.UploadService
}

func NewWishlistHandler(wishlistSer service.WishlistService, jwtSecret string, uploadSer service.UploadService) wishlistHandler {
	return wishlistHandler{wishlistSer: wishlistSer, jwtSecret: jwtSecret, uploadSer: uploadSer}
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
			Price:           wishlist.Price,
			LinkURL:         wishlist.LinkURL,
			ItemPic:         wishlist.ItemPic,
			AlreadyBought:   wishlist.AlreadyBought,
			GrantedByUserID: wishlist.GrantedByUserID,
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
			Price:           wishlist.Price,
			LinkURL:         wishlist.LinkURL,
			ItemPic:         wishlist.ItemPic,
			AlreadyBought:   wishlist.AlreadyBought,
			GrantedByUserID: wishlist.GrantedByUserID,
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
		Price:           wishlist.Price,
		LinkURL:         wishlist.LinkURL,
		ItemPic:         wishlist.ItemPic,
		AlreadyBought:   wishlist.AlreadyBought,
		GrantedByUserID: wishlist.GrantedByUserID,
	}

	return c.JSON(wishlistResponse)
}

//****************************************************************************

func (h *wishlistHandler) GetWishlistsOfCurrentUser(c *fiber.Ctx) error {
	// Extract the token from the request headers
	token := c.Get("Authorization")

	// Check if the token is empty
	if token == "" {
		return errors.New("token is missing")
	}

	// Extract the user ID from the token
	userID, err := utils.ExtractUserIDFromToken(strings.Replace(token, "Bearer ", "", 1), h.jwtSecret)
	if err != nil {
		return err
	}

	wishlists, err := h.wishlistSer.GetWishlistsOfCurrentUser(userID)
	if err != nil {
		return err
	}

	wishlistsResponse := make([]dtos.WishlistsOfCurrentUserResponse, 0)
	for _, wishlist := range wishlists {
		wishlistsResponse = append(wishlistsResponse, dtos.WishlistsOfCurrentUserResponse{
			WishlistID:        wishlist.WishlistID,
			UserID:            wishlist.UserID,
			Itemname:          wishlist.Itemname,
			Price:             wishlist.Price,
			LinkURL:           wishlist.LinkURL,
			ItemPic:           wishlist.ItemPic,
			AlreadyBought:     wishlist.AlreadyBought,
			GrantedByUserID:   wishlist.GrantedByUserID,
			UsernameOfGranter: wishlist.UsernameOfGranter,
		})
	}
	return c.JSON(wishlistsResponse)
}

func (h *wishlistHandler) GetFriendsWishlists(c *fiber.Ctx) error {

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
			Price:              wishlist.Price,
			LinkURL:            wishlist.LinkURL,
			ItemPic:            wishlist.ItemPic,
			AlreadyBought:      wishlist.AlreadyBought,
			GrantedByUserID:    wishlist.GrantedByUserID,
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
		Price:           wishlist.Price,
		LinkURL:         wishlist.LinkURL,
		ItemPic:         wishlist.ItemPic,
		AlreadyBought:   wishlist.AlreadyBought,
		GrantedByUserID: wishlist.GrantedByUserID,
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
			Price:              wishlist.Price,
			LinkURL:            wishlist.LinkURL,
			ItemPic:            wishlist.ItemPic,
			AlreadyBought:      wishlist.AlreadyBought,
			GrantedByUserID:    wishlist.GrantedByUserID,
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

func (h *wishlistHandler) PostAddWishlist(c *fiber.Ctx) error {
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

	var request dtos.AddWishlistRequest
	if err := c.BodyParser(&request); err != nil {
		return err
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
	request.ItemPic = fileURL

	// Check if user_pic field is empty or nil
	if request.ItemPic == nil {
		return fiber.NewError(fiber.StatusBadRequest, "Item picture is required")
	}

	wishlist, err := h.wishlistSer.PostAddWishlist(userIDExtract, request)
	if err != nil {
		return err
	}

	wishlistResponse := dtos.AddWishlistRequest{
		UserID:   wishlist.UserID,
		Itemname: wishlist.Itemname,
		Price:    wishlist.Price,
		LinkURL:  wishlist.LinkURL,
		ItemPic:  wishlist.ItemPic,
	}

	return c.JSON(wishlistResponse)
}

func (h *wishlistHandler) PostCopyWishlist(c *fiber.Ctx) error {
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

	wishlistID, err := strconv.Atoi(c.Params("WishlistID"))
	if err != nil {
		return err
	}

	copiedWishlistItem, copiedWishlistRecord, err := h.wishlistSer.PostCopyWishlist(userIDExtract, wishlistID)
	if err != nil {
		return err
	}

	return c.JSON(fiber.Map{"message": "Wishlist item copied successfully", "copied_wishlist_item": copiedWishlistItem, "copied_wishlist_record": copiedWishlistRecord})
}
