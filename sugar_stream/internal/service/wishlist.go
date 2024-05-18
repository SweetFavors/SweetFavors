package service

import (
	"sugar_stream/internal/dtos"
	"sugar_stream/internal/entities"
)

type WishlistService interface {
	GetWishlists() ([]entities.Wishlist, error)
	GetWishlistsOfUser(int) ([]entities.Wishlist, error)
	GetWishlist(int) (*entities.Wishlist, error)
	///////////////////////////////////////////////////////////
	GetWishlistsOfCurrentUser(int) ([]entities.Wishlist, error)
	GetFriendsWishlists(int) ([]entities.Wishlist, error)
	GetWishlistDetails(int) (*entities.Wishlist, error)
	GetProfileFriendWishlists(int, int) ([]entities.Wishlist, error)

	UpdateGrantForFriend(int, int) (*entities.Wishlist, error)
	UpdateReceiverGotIt(int, int) (*entities.Wishlist, error)
	UpdateReceiverDidntGetIt(int, int) (*entities.Wishlist, error)

	PostAddWishlist(int, dtos.AddWishlistRequest) (*entities.Wishlist, error)

	PostCopyWishlist(int, int) (*entities.Wishlist, *entities.CopiedWishlist, error)
}
