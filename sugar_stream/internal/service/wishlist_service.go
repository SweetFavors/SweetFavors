package service

import (
	"log"
	"sugar_stream/internal/dtos"
	"sugar_stream/internal/entities"
	"sugar_stream/internal/repository"
	"sugar_stream/internal/utils/v"
)

type wishlistService struct {
	wishlistRepo repository.WishlistRepository
}

func NewWishlistService(wishlistRepo repository.WishlistRepository) wishlistService {
	return wishlistService{wishlistRepo: wishlistRepo}
}

func (s wishlistService) GetWishlists() ([]entities.Wishlist, error) {
	wishlists, err := s.wishlistRepo.GetAllWishlist()
	if err != nil {
		log.Println(err)
		return nil, err
	}

	wishlistResponses := []entities.Wishlist{}
	for _, wishlist := range wishlists {
		wishlistResponse := entities.Wishlist{
			WishlistID:      wishlist.WishlistID,
			UserID:          wishlist.UserID,
			Itemname:        wishlist.Itemname,
			Price:           wishlist.Price,
			LinkURL:         wishlist.LinkURL,
			ItemPic:         wishlist.ItemPic,
			AlreadyBought:   wishlist.AlreadyBought,
			GrantedByUserID: wishlist.GrantedByUserID,
		}
		wishlistResponses = append(wishlistResponses, wishlistResponse)
	}
	return wishlistResponses, nil
}

func (s wishlistService) GetWishlistsOfUser(userid int) ([]entities.Wishlist, error) {
	wishlists, err := s.wishlistRepo.GetWishlistsByUserId(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	wishlistResponses := []entities.Wishlist{}
	for _, wishlist := range wishlists {
		wishlistResponse := entities.Wishlist{
			WishlistID:      wishlist.WishlistID,
			UserID:          wishlist.UserID,
			Itemname:        wishlist.Itemname,
			Price:           wishlist.Price,
			LinkURL:         wishlist.LinkURL,
			ItemPic:         wishlist.ItemPic,
			AlreadyBought:   wishlist.AlreadyBought,
			GrantedByUserID: wishlist.GrantedByUserID,
		}
		wishlistResponses = append(wishlistResponses, wishlistResponse)
	}
	return wishlistResponses, nil
}

func (s wishlistService) GetWishlist(wishlistid int) (*entities.Wishlist, error) {
	wishlist, err := s.wishlistRepo.GetWishlistByWishlistId(wishlistid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	wishlistResponse := entities.Wishlist{
		WishlistID:      wishlist.WishlistID,
		UserID:          wishlist.UserID,
		Itemname:        wishlist.Itemname,
		Price:           wishlist.Price,
		LinkURL:         wishlist.LinkURL,
		ItemPic:         wishlist.ItemPic,
		AlreadyBought:   wishlist.AlreadyBought,
		GrantedByUserID: wishlist.GrantedByUserID,
	}
	return &wishlistResponse, nil
}

////////////////////////////////////////////////////////////////////////////////////////////////////

func (s wishlistService) GetWishlistsOfCurrentUser(userid int) ([]entities.Wishlist, error) {
	wishlists, err := s.wishlistRepo.GetAllWishlistsOfCurrentUserId(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	wishlistResponses := []entities.Wishlist{}
	for _, wishlist := range wishlists {
		wishlistResponse := entities.Wishlist{
			WishlistID:        wishlist.WishlistID,
			UserID:            wishlist.UserID,
			Itemname:          wishlist.Itemname,
			Price:             wishlist.Price,
			LinkURL:           wishlist.LinkURL,
			ItemPic:           wishlist.ItemPic,
			AlreadyBought:     wishlist.AlreadyBought,
			GrantedByUserID:   wishlist.GrantedByUserID,
			UsernameOfGranter: wishlist.UsernameOfGranter,
		}
		wishlistResponses = append(wishlistResponses, wishlistResponse)
	}
	return wishlistResponses, nil
}

func (s wishlistService) GetFriendsWishlists(userid int) ([]entities.Wishlist, error) {
	wishlists, err := s.wishlistRepo.GetAllFriendsWishlists(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	wishlistResponses := []entities.Wishlist{}
	for _, wishlist := range wishlists {
		wishlistResponse := entities.Wishlist{
			WishlistID:         wishlist.WishlistID,
			UserID:             wishlist.UserID,
			Itemname:           wishlist.Itemname,
			Price:              wishlist.Price,
			LinkURL:            wishlist.LinkURL,
			ItemPic:            wishlist.ItemPic,
			AlreadyBought:      wishlist.AlreadyBought,
			GrantedByUserID:    wishlist.GrantedByUserID,
			UsernameOfWishlist: wishlist.UsernameOfWishlist,
			UserPicOfWishlist:  wishlist.UserPicOfWishlist,
		}
		wishlistResponses = append(wishlistResponses, wishlistResponse)
	}
	return wishlistResponses, nil
}

func (s wishlistService) GetWishlistDetails(wishlistid int) (*entities.Wishlist, error) {
	wishlist, err := s.wishlistRepo.GetWishlistDetailsByWishlistId(wishlistid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	wishlistResponse := entities.Wishlist{
		WishlistID:      wishlist.WishlistID,
		UserID:          wishlist.UserID,
		Itemname:        wishlist.Itemname,
		Price:           wishlist.Price,
		LinkURL:         wishlist.LinkURL,
		ItemPic:         wishlist.ItemPic,
		AlreadyBought:   wishlist.AlreadyBought,
		GrantedByUserID: wishlist.GrantedByUserID,
	}
	return &wishlistResponse, nil
}

func (s wishlistService) GetProfileFriendWishlists(currentUserID, wishlistOwnerID int) ([]entities.Wishlist, error) {
	wishlists, err := s.wishlistRepo.GetAllProfileFriendWishlists(currentUserID, wishlistOwnerID)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	wishlistResponses := []entities.Wishlist{}
	for _, wishlist := range wishlists {
		wishlistResponse := entities.Wishlist{
			WishlistID:         wishlist.WishlistID,
			UserID:             wishlist.UserID,
			Itemname:           wishlist.Itemname,
			Price:              wishlist.Price,
			LinkURL:            wishlist.LinkURL,
			ItemPic:            wishlist.ItemPic,
			AlreadyBought:      wishlist.AlreadyBought,
			GrantedByUserID:    wishlist.GrantedByUserID,
			UsernameOfWishlist: wishlist.UsernameOfWishlist,
			UserPicOfWishlist:  wishlist.UserPicOfWishlist,
		}
		wishlistResponses = append(wishlistResponses, wishlistResponse)
	}
	return wishlistResponses, nil
}

func (s wishlistService) UpdateGrantForFriend(wishlistID, granterUserID int) (*entities.Wishlist, error) {
	wishlist, err := s.wishlistRepo.GetWishlistByWishlistId(wishlistID)
	if err != nil {
		return nil, err
	}

	bought := false
	wishlist.AlreadyBought = &bought

	wishlist.GrantedByUserID = v.UintPtr(granterUserID)

	err = s.wishlistRepo.UpdateGrantForFriend(wishlist)
	if err != nil {
		return nil, err
	}

	return wishlist, nil
}

func (s wishlistService) UpdateReceiverGotIt(wishlistID, granterUserID int) (*entities.Wishlist, error) {
	wishlist, err := s.wishlistRepo.GetWishlistByWishlistId(wishlistID)
	if err != nil {
		return nil, err
	}

	bought := true
	wishlist.AlreadyBought = &bought

	wishlist.GrantedByUserID = v.UintPtr(granterUserID)

	err = s.wishlistRepo.UpdateReceiverGotIt(wishlist)
	if err != nil {
		return nil, err
	}

	return wishlist, nil
}

func (s wishlistService) UpdateReceiverDidntGetIt(wishlistID, granterUserID int) (*entities.Wishlist, error) {
	wishlist, err := s.wishlistRepo.GetWishlistByWishlistId(wishlistID)
	if err != nil {
		return nil, err
	}

	var bought *bool = nil
	wishlist.AlreadyBought = bought

	wishlist.GrantedByUserID = v.UintPtr(granterUserID)

	err = s.wishlistRepo.UpdateReceiverDidntGetIt(wishlist)
	if err != nil {
		return nil, err
	}

	return wishlist, nil
}

func (s wishlistService) PostAddWishlist(userID int, req dtos.AddWishlistRequest) (*entities.Wishlist, error) {
	wishlist := &entities.Wishlist{
		UserID:   v.UintPtr(userID),
		Itemname: req.Itemname,
		Price:    req.Price,
		LinkURL:  req.LinkURL,
		ItemPic:  req.ItemPic,
	}

	err := s.wishlistRepo.PostAddWishlist(wishlist)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	return wishlist, nil
}

func (s wishlistService) PostCopyWishlist(userID int, wishlistID int) (*entities.Wishlist, *entities.CopiedWishlist, error) {
	originalWishlistItem, err := s.wishlistRepo.GetWishlistDetailsByWishlistId(wishlistID)
	if err != nil {
		return nil, nil, err
	}

	copiedWishlistItem := &entities.Wishlist{
		UserID:   v.UintPtr(userID),
		Itemname: originalWishlistItem.Itemname,
		Price:    originalWishlistItem.Price,
		LinkURL:  originalWishlistItem.LinkURL,
		ItemPic:  originalWishlistItem.ItemPic,
	}

	copiedWishlistRecord := &entities.CopiedWishlist{
		WishlistID:    originalWishlistItem.WishlistID,
		UserWhoCopyID: v.UintPtr(userID),
	}

	err = s.wishlistRepo.PostCopyWishlist(copiedWishlistItem, copiedWishlistRecord)
	if err != nil {
		return nil, nil, err
	}

	return copiedWishlistItem, copiedWishlistRecord, nil
}
