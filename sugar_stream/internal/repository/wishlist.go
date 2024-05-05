package repository

import "sugar_stream/internal/entities"

type WishlistRepository interface {
	GetAllWishlist() ([]entities.Wishlist, error)
	GetWishlistsByUserId(int) ([]entities.Wishlist, error)
	GetWishlistByWishlistId(int) (*entities.Wishlist, error)
	////////////////////////////////////////////////////////////////////
	GetAllWishlistsOfCurrentUserId(int) ([]entities.Wishlist, error)
	//GetAllFriendsWishlists(int) ([]entities.Wishlist, error)
	GetWishlistDetailsByWishlistId(int) (*entities.Wishlist, error)
}
