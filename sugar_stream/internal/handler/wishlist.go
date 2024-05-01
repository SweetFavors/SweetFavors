package handler

import (
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
			WishlistID: wishlist.WishlistID,
			UserID: wishlist.UserID,
			Itemname: wishlist.Itemname,
			Quantity: wishlist.Quantity,
			Price: wishlist.Price,
			LinkURL: wishlist.LinkURL,
			ItemPic: wishlist.ItemPic,
			AlreadyBought: wishlist.AlreadyBought,
		})
	}
	return c.JSON(wishlistsResponse)
}



func (h *wishlistHandler) GetWishlistOfUser(c *fiber.Ctx) error {
    // userIDExtract, err := 1, nil
    // if err != nil {
    //     return err
    // }
	userIDExtract := 1

    wishlist, err := h.wishlistSer.GetWishlistOfUser(userIDExtract)
    if err != nil {
        return err
    }

    wishlistResponse := dtos.WishlistResponse{
		WishlistID: wishlist.WishlistID,
		UserID: wishlist.UserID,
		Itemname: wishlist.Itemname,
		Quantity: wishlist.Quantity,
		Price: wishlist.Price,
		LinkURL: wishlist.LinkURL,
		ItemPic: wishlist.ItemPic,
		AlreadyBought: wishlist.AlreadyBought,
    }

    return c.JSON(wishlistResponse)
}



func (h *wishlistHandler) GetWishlist(c *fiber.Ctx) error {
    // userIDExtract, err := 1, nil
    // if err != nil {
    //     return err
    // }
	wishlistIDReceive:= 3

    wishlist, err := h.wishlistSer.GetWishlist(wishlistIDReceive)
    if err != nil {
        return err
    }

    wishlistResponse := dtos.WishlistResponse{
		WishlistID: wishlist.WishlistID,
		UserID: wishlist.UserID,
		Itemname: wishlist.Itemname,
		Quantity: wishlist.Quantity,
		Price: wishlist.Price,
		LinkURL: wishlist.LinkURL,
		ItemPic: wishlist.ItemPic,
		AlreadyBought: wishlist.AlreadyBought,
    }

    return c.JSON(wishlistResponse)
}