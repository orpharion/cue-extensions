package cmd

import (
	"github.com/orpharion/cue-extensions/internal/builtin/panic"
	"io"
	"io/ioutil"
	"os"
)

func getFrom(args []string) []byte{
	var path string
	switch len(args) {
	case 0:
		path = "-"
	default:
		path = args[0]
	}
	switch path {
	case "-":
		return panic.Expect(ioutil.ReadAll(os.Stdin)).([]byte)
	default:
		return panic.Expect(os.ReadFile(path)).([]byte)
	}
}
func getWriter(path string) io.WriteCloser{
	switch path {
	case "-":
		return os.Stdout
	default:
		return panic.Expect(os.OpenFile(path, os.O_CREATE | os.O_WRONLY, 0666)).(*os.File)
	}
}
