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
	result := r.db.Table("wishlists").
		Select("wishlists.*, users.username AS username_of_granter").
		Joins("LEFT JOIN users ON wishlists.granted_by_user_id = users.user_id").
		Where("wishlists.user_id = ?", userid).
		Find(&wishlists)
	if result.Error != nil {
		return nil, result.Error
	}
	return wishlists, nil
}

func (r wishlistRepositoryDB) GetAllFriendsWishlists(userid int) ([]entities.Wishlist, error) {
	wishlists := []entities.Wishlist{}

	result := r.db.Table("wishlists").
		Select("wishlists.*, users.username as username_of_wishlist, users.user_pic as user_pic_of_wishlist").
		Joins("LEFT JOIN users ON wishlists.user_id = users.user_id").
		Joins("LEFT JOIN follows AS f1 ON wishlists.user_id = f1.user_id AND f1.following_id = ? AND wishlists.user_id != ?", userid, userid).
		Joins("LEFT JOIN follows AS f2 ON wishlists.user_id = f2.following_id AND f2.user_id = ? AND wishlists.user_id != ?", userid, userid).
		Where("f1.user_id IS NOT NULL AND f2.user_id IS NOT NULL").
		Where("wishlists.already_bought IS NULL").
		Where("wishlists.granted_by_user_id IS NULL").
		Where("wishlists.wishlist_id NOT IN (?)", r.db.Table("copied_wishlists").Select("wishlist_id").Where("user_who_copy_id = ?", userid)).
		Order("wishlist_id").
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

func (r wishlistRepositoryDB) GetAllProfileFriendWishlists(currentUserID, wishlistOwnerID int) ([]entities.Wishlist, error) {
	wishlists := []entities.Wishlist{}

	result := r.db.Table("wishlists").
		Select("wishlists.*, users.username as username_of_wishlist, users.user_pic as user_pic_of_wishlist").
		Joins("INNER JOIN follows AS f1 ON wishlists.user_id = f1.following_id AND f1.user_id = ?", currentUserID).
		Joins("INNER JOIN follows AS f2 ON wishlists.user_id = f2.user_id AND f2.following_id = ?", currentUserID).
		Joins("LEFT JOIN users ON wishlists.user_id = users.user_id").
		Where("wishlists.user_id = ?", wishlistOwnerID).
		Where("wishlists.already_bought IS NULL").
		Where("wishlists.granted_by_user_id IS NULL").
		Scan(&wishlists)

	if result.Error != nil {
		return nil, result.Error
	}

	return wishlists, nil
}

func (r wishlistRepositoryDB) UpdateGrantForFriend(wishlist *entities.Wishlist) error {
	result := r.db.Save(wishlist)
	if result.Error != nil {
		return result.Error
	}

	return nil
}

func (r wishlistRepositoryDB) UpdateReceiverGotIt(wishlist *entities.Wishlist) error {
	result := r.db.Save(wishlist)
	if result.Error != nil {
		return result.Error
	}

	return nil
}

func (r wishlistRepositoryDB) UpdateReceiverDidntGetIt(wishlist *entities.Wishlist) error {
	result := r.db.Save(wishlist)
	if result.Error != nil {
		return result.Error
	}

	return nil
}

func (r wishlistRepositoryDB) PostAddWishlist(wishlist *entities.Wishlist) error {
	result := r.db.Create(wishlist)
	if result.Error != nil {
		return result.Error
	}
	return nil
}

func (r wishlistRepositoryDB) PostCopyWishlist(wishlist *entities.Wishlist, copiedwishlist *entities.CopiedWishlist) error {
	resultW := r.db.Create(wishlist)
	if resultW.Error != nil {
		return resultW.Error
	}

	resultC := r.db.Create(copiedwishlist)
	if resultC.Error != nil {
		return resultC.Error
	}
	return nil

}
