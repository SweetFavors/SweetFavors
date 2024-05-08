package main

import (
	"fmt"
	"log"
	"strings"
	"sugar_stream/internal/entities"
	"sugar_stream/internal/handler"
	"sugar_stream/internal/repository"
	"sugar_stream/internal/service"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/spf13/viper"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

func main() {
	initTimeZone()
	initConfig()
	//dsn := "BocchiKitsuNei:Crown1003@tcp(localhost:3306)/toDoListMariaDB?parseTime=true"
	dsn := fmt.Sprintf("%v:%v@tcp(%v:%v)/%v?parseTime=true",
		viper.GetString("db.username"),
		viper.GetString("db.password"),
		viper.GetString("db.host"),
		viper.GetInt("db.port"),
		viper.GetString("db.database"),
	)
	log.Println(dsn)

	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})

	if err != nil {
		panic("Failed to connect database")
	}

	err = db.AutoMigrate(&entities.User{}, &entities.Wishlist{}, &entities.Follow{})
	if err != nil {
		panic("Failed to AutoMigrate")
	}

	userRepositoryDB := repository.NewUserRepositoryDB(db)
	wishlistRepositoryDB := repository.NewWishlistRepositoryDB(db)
	followRepositoryDB := repository.NewFollowRepositoryDB(db)

	userService := service.NewUserService(userRepositoryDB)
	wishlistService := service.NewWishlistService(wishlistRepositoryDB)
	followService := service.NewFollowService(followRepositoryDB)

	userHandler := handler.NewUserHandler(userService)
	wishlistHandler := handler.NewWishlistHandler(wishlistService)
	followHandler := handler.NewFollowHandler(followService)

	app := fiber.New()

	//Endpoint ###########################################################################

	// Just endpoint of test (Don't use it. Use down there endpoint)
	app.Get("/Users", userHandler.GetUsers)
	app.Get("/User/:UserID", userHandler.GetUser)

	app.Get("/UserCurrent", userHandler.GetUserCurrent)

	//------------------------------------------------------------------------------------

	app.Get("/Wishlists", wishlistHandler.GetWishlists)
	app.Get("/Wishlist/:WishlistID", wishlistHandler.GetWishlist)

	app.Get("/WishlistOfUser/:UserID", wishlistHandler.GetWishlistsOfUser)

	//------------------------------------------------------------------------------------

	app.Get("/Follows", followHandler.GetFollows)

	app.Get("/Following/:UserID", followHandler.GetFollowing)
	app.Get("/Followers/:UserID", followHandler.GetFollowers)

	//////////////////////////////////////////////////////////////////////////////////////

	// Use this endpoint for project
	//app.Post("/PostRegister", userHandler.PostRegister)
	app.Get("/GetWishlistsOfCurrentUser/:UserID", wishlistHandler.GetWishlistsOfCurrentUser)
	app.Get("/GetProfileOfCurrentUser/:UserID", userHandler.GetProfileOfCurrentUser)

	app.Get("/GetFollowingOfCurrentUser/:UserID", followHandler.GetFollowingOfCurrentUser)
	app.Get("/GetFollowersOfCurrentUser/:UserID", followHandler.GetFollowersOfCurrentUser)
	app.Get("/GetSearchFriend/:UserID", userHandler.GetSearchFriend)
	app.Get("/GetFriendsWishlists/:UserID", wishlistHandler.GetFriendsWishlists)
	app.Get("/GetWishlistDetails/:WishlistID", wishlistHandler.GetWishlistDetails)
	app.Get("/GetDonateInfo/:UserID", userHandler.GetDonateInfo)
	app.Get("/GetProfileFriendWishlists/:UserID", wishlistHandler.GetProfileFriendWishlists)
	app.Get("/Following/:UserID", followHandler.GetFollowing)
	//#####################################################################################

	log.Printf("ToDoList run at port:  %v", viper.GetInt("app.port"))
	app.Listen(fmt.Sprintf(":%v", viper.GetInt("app.port")))

}

func initConfig() {
	viper.SetConfigName("config")
	viper.SetConfigType("yaml")
	viper.AddConfigPath(".")
	viper.AutomaticEnv()
	viper.SetEnvKeyReplacer(strings.NewReplacer(".", "_"))

	err := viper.ReadInConfig()
	if err != nil {
		panic(err)
	}
}

func initTimeZone() {
	ict, err := time.LoadLocation("Asia/Bangkok")
	if err != nil {
		panic(err)
	}

	time.Local = ict
}
