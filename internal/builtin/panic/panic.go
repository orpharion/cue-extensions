package panic

func With(v interface{}) {
	panic(v)
}
func On(err error) {
	if err != nil {
		panic(err)
	}
}

func Expect(value interface{}, err error) interface{} {
	On(err)
	return value
}

func Unless(ok bool, msg *string) {
	if !ok {
		if msg != nil {
			*msg = ""
		}
		panic(msg)
	}
}

func NotImplemented() {
	panic("Not implemented")
}
