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

	jwtware "github.com/gofiber/contrib/jwt"
	"github.com/gofiber/fiber/v2"

	"github.com/spf13/viper"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

const jwtSecret = "SweetSecret"

func main() {
	initTimeZone()
	initConfig()
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

	err = db.AutoMigrate(&entities.User{})
	if err != nil {
		panic("Failed to AutoMigrate User")
	}

	err = db.AutoMigrate(&entities.Wishlist{})
	if err != nil {
		panic("Failed to AutoMigrate Wishlist")
	}

	err = db.AutoMigrate(&entities.Follow{})
	if err != nil {
		panic("Failed to AutoMigrate Follow")
	}

	userRepositoryDB := repository.NewUserRepositoryDB(db)
	wishlistRepositoryDB := repository.NewWishlistRepositoryDB(db)
	followRepositoryDB := repository.NewFollowRepositoryDB(db)

	userService := service.NewUserService(userRepositoryDB, jwtSecret)
	wishlistService := service.NewWishlistService(wishlistRepositoryDB)
	followService := service.NewFollowService(followRepositoryDB)

	userHandler := handler.NewUserHandler(userService, jwtSecret)
	wishlistHandler := handler.NewWishlistHandler(wishlistService)
	followHandler := handler.NewFollowHandler(followService)

	app := fiber.New()

	app.Use(func(c *fiber.Ctx) error {
		if c.Path() != "/Register" && c.Path() != "/Login" {
			jwtMiddleware := jwtware.New(jwtware.Config{
				SigningKey: jwtware.SigningKey{Key: []byte(jwtSecret)},
				ErrorHandler: func(c *fiber.Ctx, err error) error {
					return fiber.ErrUnauthorized
				},
			})
			return jwtMiddleware(c)
		}
		return c.Next()
	})

	//Endpoint ###########################################################################

	// Just endpoint of test (Don't use it. Use down there endpoint)
	app.Get("/Users", userHandler.GetUsers)
	app.Get("/User/:UserID", userHandler.GetUser)

	app.Get("/UserCurrent", userHandler.GetUserCurrent)

	app.Get("/Wishlists", wishlistHandler.GetWishlists)
	app.Get("/Wishlist/:WishlistID", wishlistHandler.GetWishlist)

	app.Get("/WishlistOfUser/:UserID", wishlistHandler.GetWishlistsOfUser)

	app.Get("/Follows", followHandler.GetFollows)

	app.Get("/Following/:UserID", followHandler.GetFollowing)
	app.Get("/Followers/:UserID", followHandler.GetFollowers)

	//////////////////////////////////////////////////////////////////////////////////////

	// Use this endpoint for project
	app.Post("/Register", userHandler.Register)
	app.Post("/Login", userHandler.Login)

	app.Get("/GetWishlistsOfCurrentUser/:UserID", wishlistHandler.GetWishlistsOfCurrentUser)
	app.Get("/GetProfileOfCurrentUser/:UserID", userHandler.GetProfileOfCurrentUser)

	app.Get("/GetFollowingOfCurrentUser/:UserID", followHandler.GetFollowingOfCurrentUser)
	app.Get("/GetFollowersOfCurrentUser/:UserID", followHandler.GetFollowersOfCurrentUser)
	app.Get("/GetSearchFriend/:UserID", userHandler.GetSearchFriend)
	app.Get("/GetFriendsWishlists/:UserID", wishlistHandler.GetFriendsWishlists)
	app.Get("/GetWishlistDetails/:WishlistID", wishlistHandler.GetWishlistDetails)
	app.Get("/GetProfileFriendWishlists/:CurrentUserID/:WishlistOwnerID", wishlistHandler.GetProfileFriendWishlists)

	app.Put("/UpdateGrantForFriend/:WishlistID/:GranterUserID", wishlistHandler.UpdateGrantForFriend)
	app.Put("/UpdateReceiverGotIt/:WishlistID/:GranterUserID", wishlistHandler.UpdateReceiverGotIt)
	app.Put("/UpdateReceiverDidntGetIt/:WishlistID/:GranterUserID", wishlistHandler.UpdateReceiverDidntGetIt)

	app.Get("/GetCheckFollowingYet/:CurrentUserID/:FriendUserID", followHandler.GetCheckFollowingYet)
	app.Post("/PostAddToFollowing/:CurrentUserID/:FriendUserID", followHandler.PostAddToFollowing)
	app.Delete("/DeleteUnFollowing/:CurrentUserID/:FriendUserID", followHandler.DeleteUnFollowing)

	app.Post("/PostAddWishlist/:UserID", wishlistHandler.PostAddWishlist)

	app.Get("/GetEditUserProfile/:UserID", userHandler.GetEditUserProfile)
	app.Patch("/UpdateEditUserProfile/:UserID", userHandler.UpdateEditUserProfile)

	app.Post("/PostCopyWishlist/:CurrentUserID/:WishlistID", wishlistHandler.PostCopyWishlist)

	//#####################################################################################

	log.Printf("SweetFavors run at port:  %v", viper.GetInt("app.port"))
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
