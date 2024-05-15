package utils

import (
	"errors"
	"github.com/dgrijalva/jwt-go"
	"strconv"
	"strings"
)

func ExtractUserIDFromToken(tokenStr, jwtSecret string) (int, error) {
	tokenStr = strings.Replace(tokenStr, "Bearer ", "", 1)

	token, err := jwt.Parse(tokenStr, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, errors.New("unexpected signing method")
		}
		return []byte(jwtSecret), nil
	})

	if err != nil {
		return 0, err
	}

	if claims, ok := token.Claims.(jwt.MapClaims); ok && token.Valid {
		if userIDStr, ok := claims["iss"].(string); ok {
			userID, err := strconv.Atoi(userIDStr)
			if err != nil {
				return 0, err
			}
			return userID, nil
		}
		return 0, errors.New("userID not found in token")
	}

	return 0, errors.New("invalid token")
}
