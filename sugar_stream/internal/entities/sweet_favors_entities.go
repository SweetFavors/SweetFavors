package entities

type User struct {
	UserID 			*uint 		`gorm:"primaryKey;not null;autoIncrement"`
	Username   		*string
	Password 		*string
	Email 			*string
	Firstname 		*string
	Lastname 		*string
	PhoneNum  		*string
	UserPic 		*string
	PromptPayAcc 	*string
	PromptPayQR		*string
}

type Wishlist struct {
	WishlistID		*uint		`gorm:"primaryKey;not null;autoIncrement"`
	UserID			*uint		
	user 			User 		`gorm:"foreignKey:UserID"`
	Itemname		*string
	Quantity		*uint
	Price			*uint
	LinkURL			*string
	ItemPic			*string
	AlreadyBought	*bool
}

type Follow struct {
	UserID			*uint
	user 			User 		`gorm:"foreignKey:UserID"`
	FollowingID		*uint
}