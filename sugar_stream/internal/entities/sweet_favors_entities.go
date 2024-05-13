package entities

type User struct {
	UserID    *uint `gorm:"primaryKey;autoIncrement"`
	Username  *string
	Password  *string
	Email     *string
	Firstname *string
	Lastname  *string
	PhoneNum  *string
	UserPic   *string

	// Define associations
	Wishlists  []Wishlist `gorm:"foreignKey:UserID"`
	Followers  []Follow   `gorm:"foreignKey:FollowingID"`
	Followings []Follow   `gorm:"foreignKey:UserID"`
}

type Wishlist struct {
	WishlistID         *uint `gorm:"primaryKey;autoIncrement"`
	UserID             *uint `gorm:"not null"`
	Itemname           *string
	Price              *uint
	LinkURL            *string
	ItemPic            *string
	AlreadyBought      *bool
	GrantedByUserID    *uint   `gorm:"index"`
	UsernameOfWishlist *string `gorm:"->"`
	UserPicOfWishlist  *string `gorm:"->"`
	UsernameOfGranter  *string `gorm:"->"`
}

type Follow struct {
	UserID            *uint   `gorm:"not null"`
	FollowingID       *uint   `gorm:"not null;index"`
	FollowingUsername *string `gorm:"->"`
	FollowingUserPic  *string `gorm:"->"`
	FollowerUsername  *string `gorm:"->"`
	FollowerUserPic   *string `gorm:"->"`

	// Define associations
	User      User `gorm:"foreignKey:UserID"`
	Following User `gorm:"foreignKey:FollowingID"`
}
