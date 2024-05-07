package repository

import (
	"sugar_stream/internal/entities"

	"gorm.io/gorm"
)

type wishlistRepositoryDB struct {
	db *gorm.DB
}

func NewWishlistRepositoryDB(db *gorm.DB) wishlistRepositoryDB {
	return wishlistRepositoryDB{db: db}
}

func (r wishlistRepositoryDB) GetAllWishlist() ([]entities.Wishlist, error) {
	wishlists := []entities.Wishlist{}
	result := r.db.Find(&wishlists)
	if result.Error != nil {
		return nil, result.Error
	}
	return wishlists, nil
}

func (r wishlistRepositoryDB) GetWishlistsByUserId(userid int) ([]entities.Wishlist, error) {
	wishlists := []entities.Wishlist{}
	result := r.db.Where("user_id = ?", userid).Find(&wishlists)
	if result.Error != nil {
		return nil, result.Error
	}
	return wishlists, nil
}

func (r wishlistRepositoryDB) GetWishlistByWishlistId(wishlistid int) (*entities.Wishlist, error) {
	wishlists := entities.Wishlist{}
	result := r.db.Where("wishlist_id = ?", wishlistid).Find(&wishlists)
	if result.Error != nil {
		return nil, result.Error
	}
	return &wishlists, nil
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

func (r wishlistRepositoryDB) GetAllWishlistsOfCurrentUserId(userid int) ([]entities.Wishlist, error) {
	wishlists := []entities.Wishlist{}
	result := r.db.Where("user_id = ?", userid).Find(&wishlists)
	if result.Error != nil {
		return nil, result.Error
	}
	return wishlists, nil
}

//func (r wishlistRepositoryDB) GetFriendsWishlists(userid int) ([]entities.FriendsWishlists, error) {
//	friendsWishlists := []entities.FriendsWishlists{}
//	result := r.db.
//		Select("users.username, wishlists.*").
//		Joins("JOIN follows ON follows.following_id = users.user_id").
//		Joins("JOIN users ON users.user_id = follows.user_id").
//		Joins("JOIN wishlists ON wishlists.user_id = follows.following_id").
//		Where("follows.user_id = ?", userid).
//		Where("follows.following_id IN (SELECT following_id FROM follows WHERE user_id = ?)", userid).
//		Find(&friendsWishlists)
//	if result.Error != nil {
//		return nil, result.Error
//	}
//	return friendsWishlists, nil
//}

func (r wishlistRepositoryDB) GetWishlistDetailsByWishlistId(wishlistid int) (*entities.Wishlist, error) {
	wishlists := entities.Wishlist{}
	result := r.db.Where("wishlist_id = ?", wishlistid).Find(&wishlists)
	if result.Error != nil {
		return nil, result.Error
	}
	return &wishlists, nil
}
