package dtos

type UserResponse struct {
	UserID 			*uint		`json:"user_id" validate:"required"`
	Username    	*string		`json:"username" validate:"required"`
	Password 		*string		`json:"password" validate:"required"`
	Email 			*string		`json:"email" validate:"required"`
	Firstname 		*string		`json:"firstname" validate:"required"`
	Lastname 		*string		`json:"lastname" validate:"required"`
	PhoneNum  		*string		`json:"phone_num" validate:"required"`
	UserPic 		*string		`json:"user_pic" validate:"required"`
	PromptPayAcc 	*string		`json:"prompt_pay_acc" validate:"required"`
	PromptPayQR		*string		`json:"prompt_pay_qr" validate:"required"`
}

type UserIDInfoResponse struct {
	UserID 			*uint		`json:"user_id" validate:"required"`
	Username    	*string		`json:"username" validate:"required"`
	Password 		*string		`json:"password" validate:"required"`
	Email 			*string		`json:"email" validate:"required"`
	Firstname 		*string		`json:"firstname" validate:"required"`
	Lastname 		*string		`json:"lastname" validate:"required"`
	PhoneNum  		*string		`json:"phone_num" validate:"required"`
	UserPic 		*string		`json:"user_pic" validate:"required"`
	PromptPayAcc 	*string		`json:"prompt_pay_acc" validate:"required"`
	PromptPayQR		*string		`json:"prompt_pay_qr" validate:"required"`
}

type UserCurrentResponse struct {
	UserID 			*uint		`json:"user_id" validate:"required"`
	Username    	*string		`json:"username" validate:"required"`
	Firstname 		*string		`json:"firstname" validate:"required"`
	Lastname 		*string		`json:"lastname" validate:"required"`
	UserPic 		*string		`json:"user_pic" validate:"required"`
	PromptPayAcc 	*string		`json:"prompt_pay_acc" validate:"required"`
	PromptPayQR		*string		`json:"prompt_pay_qr" validate:"required"`
}