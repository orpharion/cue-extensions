package ast

import (
	"cuelang.org/go/cue/ast"
	"fmt"
	"github.com/mitchellh/mapstructure"
	"github.com/orpharion/cue-extensions/internal/builtin/panic"
	"reflect"
	"strings"
)

var typeClause = reflect.TypeOf((*ast.Clause)(nil)).Elem()
var typeDecl = reflect.TypeOf((*ast.Decl)(nil)).Elem()
var typeExpr = reflect.TypeOf((*ast.Expr)(nil)).Elem()
var typeLabel = reflect.TypeOf((*ast.Label)(nil)).Elem()

func newDecoder(result interface{}) *mapstructure.Decoder {
	return panic.Expect(mapstructure.NewDecoder(&mapstructure.DecoderConfig{
		DecodeHook:  decodeMapHook,
		ErrorUnused: true,
		Result:      result,
	})).(*mapstructure.Decoder)
}

func decode(source interface{}, result interface{}) interface{} {
	panic.On(newDecoder(result).Decode(source))
	return result
}

func decodeMapHook(sourceType reflect.Type, targetType reflect.Type, source interface{}) (interface{}, error) {
	switch targetType {
	case typeClause:
		return ClauseFromMap(source.(map[string]interface{})), nil
	case typeDecl:
		return DeclFromMap(source.(map[string]interface{})), nil
	case typeExpr:
		return ExprFromMap(source.(map[string]interface{})), nil
	case typeLabel:
		return LabelFromMap(source.(map[string]interface{})), nil
	}
	return source, nil
}

func has(mapping map[string]interface{}, key string) bool {
	_, ok := mapping[key]
	return ok
}

func ClauseFromMap(mapping map[string]interface{}) ast.Clause {
	return (NodeFromMap(mapping)).(ast.Clause)
}

func DeclFromMap(mapping map[string]interface{}) ast.Decl {
	if has(mapping, "From") {
		target := &ast.BadDecl{}
		decode(mapping, target)
		return target
	}
	return (NodeFromMap(mapping)).(ast.Decl)
}

func LabelFromMap(mapping map[string]interface{}) ast.Label {
	return (NodeFromMap(mapping)).(ast.Label)
}

func ExprFromMap(mapping map[string]interface{}) ast.Expr {
	if has(mapping, "From") {
		target := &ast.BadExpr{}
		decode(mapping, target)
		return target
	}
	return (NodeFromMap(mapping)).(ast.Expr)
}

func NodeFromMap(mapping map[string]interface{}) ast.Node {
	target := (ast.Node)(nil)
	_has := func(key string) bool { return has(mapping, key) }
	switch {
	case _has("Equal"):
		target = &ast.Alias{}
	case _has("At"):
		target = &ast.Attribute{}
	// BadDecl and BadExpr are handled by DeclFromMap, ExprFromMap themselves, as they are identically structured.
	case _has("ValuePos"):
		target = &ast.BasicLit{}
	case _has("Y"):
		target = &ast.BinaryExpr{}
	case _has("Bottom"):
		target = &ast.BottomLit{}
	case _has("Args"):
		target = &ast.CallExpr{}
	case _has("Clauses"):
		target = &ast.Comprehension{}
	case _has("Ellipsis"):
		target = &ast.Ellipsis{}
	// EmbedDecl - see order-dependent cases
	case _has("Optional"):
		target = &ast.Field{}
	case _has("Filename"):
		target = &ast.File{}
	case _has("For"):
		target = &ast.ForClause{}
	case _has("NamePos"):
		target = &ast.Ident{}
	case _has("If"):
		target = &ast.IfClause{}
	case _has("Specs"):
		target = &ast.ImportDecl{}
	case _has("Path"):
		target = &ast.ImportSpec{}
	case _has("Index"):
		target = &ast.IndexExpr{}
	// Interpolation - see order-dependent cases
	case _has("Let"):
		target = &ast.LetClause{}
	case _has("Lbrack") && _has("Elts"):
		target = &ast.ListLit{}
	case _has("PackagePos"):
		target = &ast.Package{}
	case _has("Lparen") && _has("X"):
		target = &ast.ParenExpr{}
	case _has("Sel"):
		target = &ast.SelectorExpr{}
	case _has("Low"):
		target = &ast.SliceExpr{}
	case _has("Lbrace"):
		target = &ast.StructLit{}

	// order-dependent cases
	// after LetClause and Alias - shares only field Expr with them
	case _has("Expr"):
		target = &ast.EmbedDecl{}
	// after ListLit and StructLit - shares only field Elts with them
	case _has("Elts"):
		target = &ast.Interpolation{}
	// after BinaryExpr - subset of
	case _has("X"):
		target = &ast.UnaryExpr{}
	default:
		var keys []string
		for key := range mapping {
			keys = append(keys, key)
		}
		panic.With(fmt.Sprintf("node with fields %s unsupported", strings.Join(keys, ", ")))
	}
	decode(mapping, target)
	//ast.AddComment()
	return target
}
