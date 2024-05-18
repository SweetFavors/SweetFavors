package service

import (
	"context"
	"fmt"
	"mime/multipart"

	"github.com/minio/minio-go/v7"
)

type uploadService struct {
	client *minio.Client
}

func NewUploadService(client *minio.Client) UploadService {
	return &uploadService{client: client}
}

func (s *uploadService) UploadFile(file *multipart.FileHeader) (*string, error) {
	ctx := context.Background()
	buffer, err := file.Open()
	if err != nil {
		return nil, err
	}

	defer buffer.Close()

	fileName := file.Filename

	_, err = s.client.PutObject(ctx, "sweetfavors", fileName, buffer, file.Size, minio.PutObjectOptions{
		ContentType: "application/octet-stream",
	})
	if err != nil {
		return nil, err
	}

	fileURL := fmt.Sprintf("http://199.241.138.79:9000/sweetfavors/%s", fileName)
	return &fileURL, err
}
