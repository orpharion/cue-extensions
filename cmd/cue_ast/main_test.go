package main

import (
	"os"
	"testing"
)

func TestCUE(t *testing.T) {
	CUE := "cmd/testdata/cue.cue"
	os.Args = []string{"cue_ast", "cue", CUE}
	main()
}

func TestJSON(t *testing.T) {
	JSON := "cmd/testdata/cue.ast.json"
	os.Args = []string{"cue_ast", "json", JSON}
	main()
}