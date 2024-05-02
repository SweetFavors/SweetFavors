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
	var follows []entities.Follow
	result := r.db.Where("user_id = ?", userid).Find(&follows)
	if result.Error != nil {
		return nil, result.Error
	}
	return follows, nil
}

func (r followRepositoryDB) GetUserIDFollowers(userid int) ([]entities.Follow, error) {
	var follows []entities.Follow
	result := r.db.Where("following_id = ?", userid).Find(&follows)
	if result.Error != nil {
		return nil, result.Error
	}
	return follows, nil
}
