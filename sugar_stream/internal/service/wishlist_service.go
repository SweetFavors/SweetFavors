package service

import (
	"log"
	"sugar_stream/internal/entities"
	"sugar_stream/internal/repository"
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
			Quantity:        wishlist.Quantity,
			Price:           wishlist.Price,
			LinkURL:         wishlist.LinkURL,
			ItemPic:         wishlist.ItemPic,
			AlreadyBought:   wishlist.AlreadyBought,
			GrantedByUserId: wishlist.GrantedByUserId,
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
			Quantity:        wishlist.Quantity,
			Price:           wishlist.Price,
			LinkURL:         wishlist.LinkURL,
			ItemPic:         wishlist.ItemPic,
			AlreadyBought:   wishlist.AlreadyBought,
			GrantedByUserId: wishlist.GrantedByUserId,
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
		Quantity:        wishlist.Quantity,
		Price:           wishlist.Price,
		LinkURL:         wishlist.LinkURL,
		ItemPic:         wishlist.ItemPic,
		AlreadyBought:   wishlist.AlreadyBought,
		GrantedByUserId: wishlist.GrantedByUserId,
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
			Quantity:          wishlist.Quantity,
			Price:             wishlist.Price,
			LinkURL:           wishlist.LinkURL,
			ItemPic:           wishlist.ItemPic,
			AlreadyBought:     wishlist.AlreadyBought,
			GrantedByUserId:   wishlist.GrantedByUserId,
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
			Quantity:           wishlist.Quantity,
			Price:              wishlist.Price,
			LinkURL:            wishlist.LinkURL,
			ItemPic:            wishlist.ItemPic,
			AlreadyBought:      wishlist.AlreadyBought,
			GrantedByUserId:    wishlist.GrantedByUserId,
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
		Quantity:        wishlist.Quantity,
		Price:           wishlist.Price,
		LinkURL:         wishlist.LinkURL,
		ItemPic:         wishlist.ItemPic,
		AlreadyBought:   wishlist.AlreadyBought,
		GrantedByUserId: wishlist.GrantedByUserId,
	}
	return &wishlistResponse, nil
}

func (s wishlistService) GetProfileFriendWishlists(userid int) ([]entities.Wishlist, error) {
	wishlists, err := s.wishlistRepo.GetAllProfileFriendWishlists(userid)
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
			Quantity:           wishlist.Quantity,
			Price:              wishlist.Price,
			LinkURL:            wishlist.LinkURL,
			ItemPic:            wishlist.ItemPic,
			AlreadyBought:      wishlist.AlreadyBought,
			GrantedByUserId:    wishlist.GrantedByUserId,
			UsernameOfWishlist: wishlist.UsernameOfWishlist,
			UserPicOfWishlist:  wishlist.UserPicOfWishlist,
		}
		wishlistResponses = append(wishlistResponses, wishlistResponse)
	}
	return wishlistResponses, nil
}
