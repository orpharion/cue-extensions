package ast

import (
	"cuelang.org/go/cue/ast"
	"github.com/mitchellh/mapstructure"
	"github.com/orpharion/cue-extensions/internal/builtin/panic"
	"reflect"
)

func newNodeEncoder(result *map[string]interface{}) *mapstructure.Decoder {
	return panic.Expect(mapstructure.NewDecoder(&mapstructure.DecoderConfig{
		DecodeHook:  encodeHook,
		ErrorUnused: true,
		Result:      result,
	})).(*mapstructure.Decoder)
}
func newMapEncoder(result *map[string]interface{}) *mapstructure.Decoder {
	return panic.Expect(mapstructure.NewDecoder(&mapstructure.DecoderConfig{
		ErrorUnused: true,
		Result:      result,
	})).(*mapstructure.Decoder)
}
func encodeNode(node ast.Node) map[string]interface{} {
	var result map[string]interface{}
	panic.On(newNodeEncoder(&result).Decode(node))
	return result
}
func encodeMap(source interface{}) map[string]interface{} {
	var result map[string]interface{}
	panic.On(newMapEncoder(&result).Decode(source))
	return result
}


func mapIdent(ident *ast.Ident) interface{} {
	mapped := map[string]interface{}{
		"Name": ident.Name,
		"NamePos":   ident.NamePos,
	}
	return mapped
}
func mapIdents(idents []*ast.Ident) []interface{} {
	items := make([]interface{}, len(idents))
	for i, ident := range idents {
		items[i] = mapIdent(ident)
	}
	return items
}

func DeclsToNodes(decls []ast.Decl) []ast.Node {
	nodes := make([]ast.Node, len(decls))
	for i, decl := range decls {
		nodes[i] = decl
	}
	return nodes
}
func ExprsToNodes(exprs []ast.Expr) []ast.Node {
	nodes := make([]ast.Node, len(exprs))
	for i, expr := range exprs {
		nodes[i] = expr
	}
	return nodes
}
func AttributesToNodes(attrs []*ast.Attribute) []ast.Node {
	nodes := make([]ast.Node, len(attrs))
	for i, attr := range attrs {
		nodes[i] = attr
	}
	return nodes
}
func ClausesToNodes(clauses []ast.Clause) []ast.Node {
	nodes := make([]ast.Node, len(clauses))
	for i, clause := range clauses {
		nodes[i] = clause
	}
	return nodes
}
func ImportSpecsToNodes(importSpecs []*ast.ImportSpec) []ast.Node {
	nodes := make([]ast.Node, len(importSpecs))
	for i, importSpec := range importSpecs {
		nodes[i] = importSpec
	}
	return nodes
}
func mapNodes(nodes []ast.Node) []interface{} {
	items :=  make([]interface{}, len(nodes))
	for i, item := range nodes {
		if node, ok := item.(ast.Node); ok {
			items[i] = encodeNode(node)
		} else {
			items[i] = item
		}
	}
	return items
}
func nodeInner(nodeMap map[string]interface{}) map[string]interface{} {
	for k, v := range nodeMap {
		if node, ok := v.(ast.Node); ok {
			nodeMap[k] = encodeNode(node)
		}
	}
	return nodeMap
}

func encodeHook(sourceType reflect.Type, targetType reflect.Type, source interface{}) (interface{}, error) {
	if ident, ok := source.(*ast.Ident); ok {
		mapped := map[string]interface{}{
			"Name": ident.Name,
			"NamePos":   ident.NamePos, // todo resolve Node and Scope (cyclic graph).
		}
		return mapped, nil
	}
	if node, ok := source.(ast.Node); ok {
		mapped := unwrapNode(node) // will still have Node interface values in map values.
		return nodeInner(mapped), nil // remap inner Node interface values
	}
	if decls, ok := source.([]ast.Decl); ok {
		nodes := DeclsToNodes(decls)
		return mapNodes(nodes), nil
	}
	if exprs, ok := source.([]ast.Expr); ok {
		nodes := ExprsToNodes(exprs)
		return mapNodes(nodes), nil
	}
	if idents, ok := source.([]*ast.Ident); ok {
		return mapIdents(idents), nil
	}
	if importSpecs, ok := source.([]*ast.ImportSpec); ok {
		nodes := ImportSpecsToNodes(importSpecs)
		return mapNodes(nodes), nil
	}
	if attrs, ok := source.([]*ast.Attribute); ok {
		nodes := AttributesToNodes(attrs)
		return mapNodes(nodes), nil
	}
	if clauses, ok := source.([]ast.Clause); ok {
		nodes := ClausesToNodes(clauses)
		return mapNodes(nodes), nil
	}
	return source, nil

}
func EncodeToPrimitives(node ast.Node) map[string]interface{} {
	return encodeNode(node)
}

func unwrapNode(node ast.Node) map[string]interface{} {
	switch x := node.(type) {
	default:
		return encodeMap(x)
	}
}
