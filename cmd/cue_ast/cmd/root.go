package cmd

import (
	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "cue_ast",
	Short: "Transcode CUE Abstract Syntax Trees to / from JSON.",
}

func Execute() {
	cobra.CheckErr(rootCmd.Execute())
}

