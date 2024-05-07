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

func (r wishlistRepositoryDB) GetAllFriendsWishlists(userid int) ([]entities.Wishlist, error) {
	wishlists := []entities.Wishlist{}

	result := r.db.Table("wishlists").
		Select("wishlists.wishlist_id, wishlists.user_id, wishlists.itemname, wishlists.quantity, wishlists.price, wishlists.link_url, wishlists.item_pic, wishlists.already_bought, wishlists.granted_by_user_id, users.username as username_of_wishlist").
		Joins("LEFT JOIN users ON wishlists.user_id = users.user_id").
		Not("wishlists.user_id = ?", userid).
		Scan(&wishlists)
	if result.Error != nil {
		return nil, result.Error
	}

	return wishlists, nil
}

func (r wishlistRepositoryDB) GetWishlistDetailsByWishlistId(wishlistid int) (*entities.Wishlist, error) {
	wishlists := entities.Wishlist{}
	result := r.db.Where("wishlist_id = ?", wishlistid).Find(&wishlists)
	if result.Error != nil {
		return nil, result.Error
	}
	return &wishlists, nil
}
