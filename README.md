# CUE extensions
Extensions for the CUE langauge.

## AST
Transform CUE source files to / from Abstract Syntax Trees in JSON (and, since CUE is a superset of JSON, CUE as well).
Intended for use with CUE source generators written in other languages.

```shell
# installation
go get github.com/orpharion/cue-extensions/cmd/cue_ast
# download testdata (if needed)
curl https://raw.githubusercontent.com/orpharion/cue-extensions/master/cmd/cue_ast/cmd/testdata/cue.ast.json > cue.ast.json
curl https://raw.githubusercontent.com/orpharion/cue-extensions/master/cmd/cue_ast/cmd/testdata/cue.cue > cue.cue
# CUE source to AST
cue_ast cue cue.cue > cue-gen.ast.json
# CUE AST to source
cue_ast json cue.ast.json > cue-gen.cue 
```

__Notes__: 
1. Error handling 

    This library is a really thin wrapper on CUE's [ast](https://github.com/cue-lang/cue/tree/master/cue/ast) 
and [format](https://github.com/cue-lang/cue/tree/master/cue/format) modules, and panics immediately if errors occur.
2. AST types

    CUE syntax nodes are uniquely determined by their field identifiers, and so no additional type / kind information is embedded. 
For an example of mapping the anonymous node structures back to their types, see this module's 
[ast](https://github.com/orpharion/cue-extensions/blob/master/pkg/ast/from_map.go) package.

3. Idents

    Identifier nodes may have pointers to their scope and node (see the [Ident type]((https://github.com/cue-lang/cue/blob/0f53054da7243c7a312cd0ad54a1083d67c185d3/cue/ast/ast.go#L400))), making the syntax graph recursive.
These fields are currently omitted, and may be resolved later by transforming them into a suitable "pointer" format.
CUE can still interpret the source, however. I am unsure what bugs may result from this.