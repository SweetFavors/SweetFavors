package repository

import (
	"sugar_stream/internal/entities"

	"gorm.io/gorm"
)

type followRepositoryDB struct {
	db *gorm.DB
}

func NewFollowRepositoryDB(db *gorm.DB) followRepositoryDB {
	return followRepositoryDB{db: db}
}

func (r followRepositoryDB) GetAllFollow() ([]entities.Follow, error) {
	follows := []entities.Follow{}
	result := r.db.Find(&follows)
	if result.Error != nil {
		return nil, result.Error
	}
	return follows, nil
}

func (r followRepositoryDB) GetUserIDFollowing(userid int) ([]entities.Follow, error) {
	follows := []entities.Follow{}
	result := r.db.Where("user_id = ?", userid).Find(&follows)
	if result.Error != nil {
		return nil, result.Error
	}
	return follows, nil
}

func (r followRepositoryDB) GetUserIDFollowers(userid int) ([]entities.Follow, error) {
	follows := []entities.Follow{}
	result := r.db.Where("following_id = ?", userid).Find(&follows)
	if result.Error != nil {
		return nil, result.Error
	}
	return follows, nil
}

//////////////////////////////////////////////////////////////////////////////////////////////////

func (r followRepositoryDB) GetFollowingOfCurrentUserId(userid int) ([]entities.Follow, error) {
	var follows []entities.Follow
	result := r.db.
		Select("follows.*, users.username as FollowingUsername, users.user_pic as FollowingUserPic").
		Joins("JOIN users ON follows.following_id = users.user_id").
		Where("follows.user_id = ?", userid).
		Find(&follows)

	if result.Error != nil {
		return nil, result.Error
	}

	return follows, nil
}

func (r followRepositoryDB) GetFollowersOfCurrentUserId(userid int) ([]entities.Follow, error) {
	follows := []entities.Follow{}
	result := r.db.
		Select("follows.*, followers.username as FollowerUsername, followers.user_pic as FollowerUserPic").
		Joins("JOIN users AS followers ON followers.user_id = follows.user_id").
		Where("follows.following_id = ?", userid).
		Find(&follows)

	if result.Error != nil {
		return nil, result.Error
	}

	return follows, nil
}

func (r followRepositoryDB) GetCheckFollowingYetByData(currentUserID, friendUserID int) (*entities.Follow, error) {
	follows := entities.Follow{}
	result := r.db.Where("user_id = ? AND following_id = ?", currentUserID, friendUserID).Find(&follows)

	if result.Error != nil {
		return nil, result.Error
	}

	return &follows, nil
}

func (r followRepositoryDB) PostAddToFollowing(follow *entities.Follow) error {
	result := r.db.Create(follow)
	if result.Error != nil {
		return result.Error
	}
	return nil
}

func (r followRepositoryDB) DeleteUnFollowing(follow *entities.Follow) error {
	result := r.db.Where("user_id = ? AND following_id = ?", follow.UserID, follow.FollowingID).Delete(&entities.Follow{})
	if result.Error != nil {
		return result.Error
	}
	return nil
}
