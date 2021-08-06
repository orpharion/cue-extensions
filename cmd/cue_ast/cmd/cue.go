package cmd

import (
	"github.com/orpharion/cue-extensions/pkg/ast"
	"github.com/spf13/cobra"
)

var cueCmd = &cobra.Command{
	Use:   "cue",
	Short: "CUE source → JSON AST.",
	Long: `The CUE source file is either:
- "-", for stdin, terminating in EOF, or
- <filename>, for file
The JSON AST is emitted to stdout by default, unless the --to flag is used.`,
	Run:  cueRun,
	Args: cobra.MaximumNArgs(1),
}

var cueTo string

func init() {
	rootCmd.AddCommand(cueCmd)
	cueCmd.Flags().StringVarP(&cueTo, "to", "t", "-", "Destination to write JSON AST")
}

func cueRun(cmd *cobra.Command, args []string) {
	filename := "-"
	if len(args) != 0 {
		filename = args[0]
	}
	fromBytes := getFrom(args)
	toWriter := getWriter(jsonTo)
	defer toWriter.Close()
	json := ast.CueToJson(filename, fromBytes)
	toWriter.Write(json)
}
