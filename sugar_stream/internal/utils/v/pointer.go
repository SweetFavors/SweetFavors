package v

func Ptr[T any](val T) *T {
	return &val
}

func UintPtr(val int) *uint {
	return Ptr(uint(val))
}
