package repository

import "sugar_stream/internal/entities"

type WishlistRepository interface {
	GetAllWishlist() ([]entities.Wishlist, error)
	GetWishlistsByUserId(int) ([]entities.Wishlist, error)
	GetWishlistByWishlistId(int) (*entities.Wishlist, error)
	////////////////////////////////////////////////////////////////////
	GetAllWishlistsOfCurrentUserId(int) ([]entities.Wishlist, error)
	GetAllFriendsWishlists(int) ([]entities.Wishlist, error)
	GetWishlistDetailsByWishlistId(int) (*entities.Wishlist, error)
	GetAllProfileFriendWishlists(int, int) ([]entities.Wishlist, error)

	UpdateGrantForFriend(wishlist *entities.Wishlist) error
	UpdateReceiverGotIt(wishlist *entities.Wishlist) error
	UpdateReceiverDidntGetIt(wishlist *entities.Wishlist) error

	PostAddWishlist(wishlist *entities.Wishlist) error

	PostCopyWishlist(wishlist *entities.Wishlist, copyproduct *entities.CopiedWishlist) error
}
