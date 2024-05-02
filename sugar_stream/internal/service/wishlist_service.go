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
			WishlistID:    wishlist.WishlistID,
			UserID:        wishlist.UserID,
			Itemname:      wishlist.Itemname,
			Quantity:      wishlist.Quantity,
			Price:         wishlist.Price,
			LinkURL:       wishlist.LinkURL,
			ItemPic:       wishlist.ItemPic,
			AlreadyBought: wishlist.AlreadyBought,
		}
		wishlistResponses = append(wishlistResponses, wishlistResponse)
	}
	return wishlistResponses, nil
}




func (s wishlistService) GetWishlistOfUser(userid int) (*entities.Wishlist, error) {
	wishlist, err := s.wishlistRepo.GetWishlistByUserId(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	wishlistResponse := entities.Wishlist{
		WishlistID:    wishlist.WishlistID,
		UserID:        wishlist.UserID,
		Itemname:      wishlist.Itemname,
		Quantity:      wishlist.Quantity,
		Price:         wishlist.Price,
		LinkURL:       wishlist.LinkURL,
		ItemPic:       wishlist.ItemPic,
		AlreadyBought: wishlist.AlreadyBought,
	}
	return &wishlistResponse, nil
}



func (s wishlistService) GetWishlist(wishlistid int) (*entities.Wishlist, error) {
	wishlist, err := s.wishlistRepo.GetWishlistByWishlistId(wishlistid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	wishlistResponse := entities.Wishlist{
		WishlistID:    wishlist.WishlistID,
		UserID:        wishlist.UserID,
		Itemname:      wishlist.Itemname,
		Quantity:      wishlist.Quantity,
		Price:         wishlist.Price,
		LinkURL:       wishlist.LinkURL,
		ItemPic:       wishlist.ItemPic,
		AlreadyBought: wishlist.AlreadyBought,
	}
	return &wishlistResponse, nil
}



