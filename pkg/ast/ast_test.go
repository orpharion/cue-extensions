package ast

import (
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/format"
	"cuelang.org/go/cue/load"
	"encoding/json"
	"github.com/orpharion/cue-extensions/internal/builtin/panic"
	"os"
	"testing"
)

func TestA(t *testing.T) {
	c := cuecontext.New()
	dir := "/home/orpharion/Documents/gitlab.arup.com/iado/GsaGenCue/dist/GsaAPI"
	panic.On(os.Chdir(dir))
	instances := load.Instances([]string{}, nil)
	panic.Unless(len(instances) == 1, nil)
	instance := instances[0]
	panic.On(instance.Err)
	value := c.BuildInstance(instance)
	panic.On(value.Err())
	node := value.Source()
	nodePrimitives := EncodeToPrimitives(node)
	jb := panic.Expect(json.MarshalIndent(nodePrimitives, "", "  ")).([]byte)
	println(string(jb))
	var mapping map[string]interface{}
	panic.On(json.Unmarshal(jb, &mapping))
	nodeRegen := NodeFromMap(mapping)
	sourceRegen := panic.Expect(format.Node(nodeRegen)).([]byte)
	println(string(sourceRegen))
}
