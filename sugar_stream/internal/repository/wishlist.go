package repository

import "sugar_stream/internal/entities"

type WishlistRepository interface {
	GetAllWishlist() ([]entities.Wishlist, error)
	GetWishlistByUserId(int) (*entities.Wishlist, error)
	GetWishlistByWishlistId(int) (*entities.Wishlist, error)

}