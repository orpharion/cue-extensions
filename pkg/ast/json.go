package ast

import (
	"cuelang.org/go/cue/ast"
	"cuelang.org/go/cue/ast/astutil"
	"cuelang.org/go/cue/parser"
	"encoding/json"
	"github.com/orpharion/cue-extensions/internal/builtin/panic"
)

func CueToJson(filename string, data []byte) []byte {
	cueFile := panic.Expect(parser.ParseFile(filename, data)).(*ast.File)
	return NodeToJson(cueFile)
}

func NodeToJson(node ast.Node) []byte {
	return panic.Expect(json.Marshal(EncodeToPrimitives(node))).([]byte)
}

func JsonToNode(data []byte) ast.Node {
	var mapping map[string]interface{}
	panic.On(json.Unmarshal(data, &mapping))
	node := NodeFromMap(mapping)
	switch x := node.(type) {
	case *ast.File:
		panic.On(astutil.Sanitize(x))
	}
	return node
}
