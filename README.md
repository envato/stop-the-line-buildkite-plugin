# Stop The Line Buildkite Plugin

![Build status](https://badge.buildkite.com/03e8876c9dbec4eb293aba87dc657e2dadf6afc6c0b9b761b4.svg)
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
