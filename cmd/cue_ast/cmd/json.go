package cmd

import (
	"cuelang.org/go/cue/format"
	"github.com/orpharion/cue-extensions/internal/builtin/panic"
	"github.com/orpharion/cue-extensions/pkg/ast"
	"github.com/spf13/cobra"
)

var jsonCmd = &cobra.Command{
	Use:   "json",
	Short: "JSON AST → CUE source.",
	Long: `The JSON AST file is either:
- "-", for stdin, terminating in EOF, or
- <filename>, for file
The CUE source is emitted to stdout by default, unless the --to flag is used.`,
	Run: jsonRun,
}

var jsonTo string

func init() {
	rootCmd.AddCommand(jsonCmd)
	jsonCmd.Flags().StringVarP(&jsonTo, "to", "t", "-", "Destination to write CUE source")
}

func jsonRun(cmd *cobra.Command, args []string) {
	fromBytes := getFrom(args)
	toWriter := getWriter(cueTo)
	defer toWriter.Close()
	node := ast.JsonToNode(fromBytes)
	cue := panic.Expect(format.Node(node)).([]byte)
	toWriter.Write(cue)
}
