package dtos

type FollowResponse struct {
	UserID      *uint `json:"user_id" validate:"required"`
	FollowingID *uint `json:"following_id" validate:"required"`
}

type FollowingResponse struct {
	UserID      *uint `json:"user_id" validate:"required"`
	FollowingID *uint `json:"following_id" validate:"required"`
}

type FollowersResponse struct {
	UserID      *uint `json:"user_id" validate:"required"`
	FollowingID *uint `json:"following_id" validate:"required"`
}

////////////////////////////////////////////////////////////////////////////////

type FollowingOfCurrentUserResponse struct {
	UserID            *uint   `json:"user_id" validate:"required"`
	FollowingID       *uint   `json:"following_id" validate:"required"`
	FollowingUsername *string `json:"following_username" validate:"required"`
	FollowingUserPic  *string `json:"following_user_pic" validate:"required"`
}

type FollowersOfCurrentUserResponse struct {
	UserID           *uint   `json:"user_id" validate:"required"`
	FollowingID      *uint   `json:"following_id" validate:"required"`
	FollowerUsername *string `json:"follower_username" validate:"required"`
	FollowerUserPic  *string `json:"follower_user_pic" validate:"required"`
}

type CheckFollowingYetResponse struct {
	UserID      *uint `json:"user_id" validate:"required"`
	FollowingID *uint `json:"following_id" validate:"required"`
}
