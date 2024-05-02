package dtos

type FollowResponse struct {
	UserID 			*uint		`json:"user_id" validate:"required"`
	FollowingID		*uint		`json:"following_id" validate:"required"`
}

type FollowingResponse struct {
	UserID 			*uint		`json:"user_id" validate:"required"`
	FollowingID		*uint		`json:"following_id" validate:"required"`
}

type FollowersResponse struct {
	UserID 			*uint		`json:"user_id" validate:"required"`
	FollowingID		*uint		`json:"following_id" validate:"required"`
}