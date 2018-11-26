#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

# Uncomment the following to get more detail on failures of stubs
# export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty

@test 'IF: given pass style and the meta-data matches, the remaining build steps are replaced with nothing' {
  export BUILDKITE_PLUGIN_STOP_THE_LINE_IF_KEY=test-key
  export BUILDKITE_PLUGIN_STOP_THE_LINE_IF_VALUE=test-value
  export BUILDKITE_PLUGIN_STOP_THE_LINE_STYLE=pass

  stub buildkite-agent \
    'meta-data get test-key : echo "test-value"' \
    'pipeline upload --replace : cat'

  run $PWD/hooks/command

  assert_success
  assert_output --partial 'steps: []'
  unstub buildkite-agent
}

@test 'IF: given fail style and the meta-data matches, the step exits with error value' {
  export BUILDKITE_PLUGIN_STOP_THE_LINE_IF_KEY=test-key
  export BUILDKITE_PLUGIN_STOP_THE_LINE_IF_VALUE=test-value
  export BUILDKITE_PLUGIN_STOP_THE_LINE_STYLE=fail

  stub buildkite-agent 'meta-data get test-key : echo "test-value"'

  run $PWD/hooks/command

  assert_failure
  unstub buildkite-agent
}

@test 'IF: given the meta-data does not match, the step passes' {
  export BUILDKITE_PLUGIN_STOP_THE_LINE_IF_KEY=test-key
  export BUILDKITE_PLUGIN_STOP_THE_LINE_IF_VALUE=test-value
  export BUILDKITE_PLUGIN_STOP_THE_LINE_STYLE=fail

  stub buildkite-agent 'meta-data get test-key : echo "not a match"'

  run $PWD/hooks/command

  assert_success
  unstub buildkite-agent
}

@test 'UNLESS: given pass style and the meta-data does not match, the remaining build steps are replaced with nothing' {
  export BUILDKITE_PLUGIN_STOP_THE_LINE_UNLESS_KEY=test-key
  export BUILDKITE_PLUGIN_STOP_THE_LINE_UNLESS_VALUE=test-value
  export BUILDKITE_PLUGIN_STOP_THE_LINE_STYLE=pass

  stub buildkite-agent \
    'meta-data get test-key : echo "does-not-match"' \
    'pipeline upload --replace : cat'

  run $PWD/hooks/command

  assert_success
  assert_output --partial 'steps: []'
  unstub buildkite-agent
}

@test 'UNLESS: given fail style and the meta-data does not match, the step exits with error value' {
  export BUILDKITE_PLUGIN_STOP_THE_LINE_UNLESS_KEY=test-key
  export BUILDKITE_PLUGIN_STOP_THE_LINE_UNLESS_VALUE=test-value
  export BUILDKITE_PLUGIN_STOP_THE_LINE_STYLE=fail

  stub buildkite-agent 'meta-data get test-key : echo "does-not-match"'

  run $PWD/hooks/command

  assert_failure
  unstub buildkite-agent
}

@test 'UNLESS: given the meta-data matches, the step passes' {
  export BUILDKITE_PLUGIN_STOP_THE_LINE_UNLESS_KEY=test-key
  export BUILDKITE_PLUGIN_STOP_THE_LINE_UNLESS_VALUE=test-value
  export BUILDKITE_PLUGIN_STOP_THE_LINE_STYLE=fail

  stub buildkite-agent 'meta-data get test-key : echo "test-value"'

  run $PWD/hooks/command

  assert_success
  unstub buildkite-agent
}
