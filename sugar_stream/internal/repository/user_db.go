package repository

import (
	"sugar_stream/internal/entities"

	"gorm.io/gorm"
)

type userRepositoryDB struct {
	db *gorm.DB
}

func NewUserRepositoryDB(db *gorm.DB) userRepositoryDB {
	return userRepositoryDB{db: db}
}

func (r userRepositoryDB) GetAllUser() ([]entities.User, error) {
	users := []entities.User{}
	result := r.db.Find(&users)
	if result.Error != nil {
		return nil, result.Error
	}
	return users, nil
}

func (r userRepositoryDB) GetUserById(userid int) (*entities.User, error) {
	users := entities.User{}
	result := r.db.Where("user_id = ?", userid).Find(&users)
	if result.Error != nil {
		return nil, result.Error
	}
	return &users, nil
}

/////////////////////////////////////////////////////////////////////////////////////////////

func (r userRepositoryDB) GetProfileOfCurrentUserId(userid int) (*entities.User, error) {
	users := entities.User{}
	result := r.db.Where("user_id = ?", userid).Find(&users)
	if result.Error != nil {
		return nil, result.Error
	}
	return &users, nil
}

func (r userRepositoryDB) GetAllSearchFriend(excludeUserID int) ([]entities.User, error) {
	users := []entities.User{}
	result := r.db.Not("user_id = ?", excludeUserID).Find(&users)
	if result.Error != nil {
		return nil, result.Error
	}
	return users, nil
}

func (r userRepositoryDB) GetDonateInfoByUserId(userid int) (*entities.User, error) {
	users := entities.User{}
	result := r.db.Where("user_id = ?", userid).Find(&users)
	if result.Error != nil {
		return nil, result.Error
	}
	return &users, nil
}

func (r userRepositoryDB) GetEditUserProfile(userid int) (*entities.User, error) {
	users := entities.User{}
	result := r.db.Where("user_id = ?", userid).Find(&users)
	if result.Error != nil {
		return nil, result.Error
	}
	return &users, nil
}

//func (r userRepositoryDB) PostRegister() (*entities.User, error) {
//	users := entities.User{}
//
//	if result.Error != nil {
//		return nil, result.Error
//	}
//	return &users, nil
//}
