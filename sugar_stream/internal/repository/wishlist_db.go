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

//func (r wishlistRepositoryDB) GetFriendsWishlists(userid int) ([]entities.Wishlist, error) {
//	wishlists := []entities.Wishlist{}
//	result := r.db.Where("user_id = ?", userid).Find(&wishlists)
//	if result.Error != nil {
//		return nil, result.Error
//	}
//	return wishlists, nil
//}

func (r wishlistRepositoryDB) GetWishlistDetailsByWishlistId(wishlistid int) (*entities.Wishlist, error) {
	wishlists := entities.Wishlist{}
	result := r.db.Where("wishlist_id = ?", wishlistid).Find(&wishlists)
	if result.Error != nil {
		return nil, result.Error
	}
	return &wishlists, nil
}
