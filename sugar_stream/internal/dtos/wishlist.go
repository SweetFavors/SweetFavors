package dtos

type WishlistResponse struct {
	WishlistID		*uint		`json:"wishlist_id" validate:"required"`
	UserID			*uint		`json:"user_id" validate:"required"`
	Itemname		*string		`json:"itemname" validate:"required"`
	Quantity		*uint		`json:"quantity" validate:"required"`
	Price			*uint		`json:"price" validate:"required"`
	LinkURL			*string		`json:"linkurl" validate:"required"`
	ItemPic			*string		`json:"item_pic" validate:"required"`
	AlreadyBought	*bool		`json:"already_bought" validate:"required"`
}

type WishlistUserCurrentResponse struct {
	WishlistID		*uint		`json:"wishlist_id" validate:"required"`
	UserID			*uint		`json:"user_id" validate:"required"`
	Itemname		*string		`json:"itemname" validate:"required"`
	Quantity		*uint		`json:"quantity" validate:"required"`
	Price			*uint		`json:"price" validate:"required"`
	LinkURL			*string		`json:"linkurl" validate:"required"`
	ItemPic			*string		`json:"item_pic" validate:"required"`
	AlreadyBought	*bool		`json:"already_bought" validate:"required"`
}

type WishlistIDInfoResponse struct {
	WishlistID		*uint		`json:"wishlist_id" validate:"required"`
	UserID			*uint		`json:"user_id" validate:"required"`
	Itemname		*string		`json:"itemname" validate:"required"`
	Quantity		*uint		`json:"quantity" validate:"required"`
	Price			*uint		`json:"price" validate:"required"`
	LinkURL			*string		`json:"linkurl" validate:"required"`
	ItemPic			*string		`json:"item_pic" validate:"required"`
	AlreadyBought	*bool		`json:"already_bought" validate:"required"`
}