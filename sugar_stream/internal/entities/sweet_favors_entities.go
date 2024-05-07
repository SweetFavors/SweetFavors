package entities

type User struct {
	UserID       *uint `gorm:"primaryKey;autoIncrement"`
	Username     *string
	Password     *string
	Email        *string
	Firstname    *string
	Lastname     *string
	PhoneNum     *string
	UserPic      *string
	PromptPayAcc *string
	PromptPayQR  *string
	Wishlist     []Wishlist `gorm:"foreignKey:UserID"`
	GrantedBy    []Wishlist `gorm:"foreignKey:GrantedByUserId"`
	Followers    []Follow   `gorm:"foreignKey:UserID"`
	Following    []Follow   `gorm:"foreignKey:FollowingID"`
}

type Wishlist struct {
	WishlistID         *uint `gorm:"primaryKey;autoIncrement"`
	UserID             *uint `gorm:"not null"`
	User               User  `gorm:"foreignKey:UserID"`
	Itemname           *string
	Quantity           *uint
	Price              *uint
	LinkURL            *string
	ItemPic            *string
	AlreadyBought      *bool
	GrantedByUserId    *uint
	UsernameOfWishlist *string `gorm:"->"`
	UserPicOfWishlist  *string `gorm:"->"`
	UsernameOfGranter  *string `gorm:"->"`
}

type Follow struct {
	UserID            *uint   `gorm:"not null"`
	User              User    `gorm:"foreignKey:UserID"`
	FollowingID       *uint   `gorm:"not null"`
	Following         User    `gorm:"foreignKey:FollowingID"`
	FollowingUsername *string `gorm:"->"`
	FollowingUserPic  *string `gorm:"->"`
	FollowerUsername  *string `gorm:"->"`
	FollowerUserPic   *string `gorm:"->"`
}
