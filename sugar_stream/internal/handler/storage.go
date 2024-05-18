package handler

import (
	"sugar_stream/internal/service"

	"github.com/gofiber/fiber/v2"
)

type StorageHandler struct {
	uploadSer service.UploadService
}

func NewStorageHandler(uploadSer service.UploadService) *StorageHandler {
	return &StorageHandler{
		uploadSer: uploadSer,
	}
}

func (h *StorageHandler) UploadFile(c *fiber.Ctx) error {
	file, err := c.FormFile("file")
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "File not found",
		})
	}

	info, err := h.uploadSer.UploadFile(file)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Failed to upload file",
		})
	}
	return c.SendString(*info)
}
