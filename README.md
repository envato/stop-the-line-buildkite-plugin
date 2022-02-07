# Stop The Line Buildkite Plugin

[![tests](https://github.com/envato/stop-the-line-buildkite-plugin/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/envato/stop-the-line-buildkite-plugin/actions/workflows/tests.yml)
[![MIT License](https://img.shields.io/badge/License-MIT-brightgreen.svg)](LICENSE)

A [Buildkite plugin] that stops build if a metadata key has a certain value.

## Example

```yml
steps:
  - label: ":octagonal_sign:"
    plugins:
      - envato/stop-the-line#v0.1.0:
          if:
            key: "no-more-work"
            value: "true"
          style: "pass"
```

```yml
steps:
  - label: ":octagonal_sign:"
    plugins:
      - envato/stop-the-line#v0.1.0:
          unless:
            key: "sky"
            value: "blue"
          style: "fail"
```

## Development

To run the tests:

```sh
docker-compose run --rm tests
```

To run the [Buildkite Plugin Linter]:

```sh
docker-compose run --rm lint
```

[Buildkite Plugin]: https://buildkite.com/docs/agent/v3/plugins
[Buildkite Plugin Linter]: https://github.com/buildkite-plugins/buildkite-plugin-linter
