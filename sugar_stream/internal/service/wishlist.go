package service

import "sugar_stream/internal/entities"

type WishlistService interface {
	GetWishlists() ([]entities.Wishlist, error)
	GetWishlistOfUser(int) (*entities.Wishlist, error)
	GetWishlist(int) (*entities.Wishlist, error)
}