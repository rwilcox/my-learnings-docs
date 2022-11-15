---
path: /learnings/circleci
title: 'Learnings: CircleCI'
---
# Table Of Contents

<!-- toc -->

# Path filtering orb

## Silly example

config.yml:

```yaml
version: 2.1
setup: true

orbs:
  path-filtering: circleci/path-filtering@0.1.3

werkflows:
  setup:
    jobs:
      - path-filtering/filter:
          base-revision: main
          config-map: .circleci/extra-config.yml
          mapping: |
            regex-we-match-log-lines-against/.* parameter-name-but-can-be-only-one "value json literal"
```

the "value json literal" spot can be any JSON literal: strings (yes, including the quotes), true/false, numbers, etc.

extra-config.yml

```yaml
version: 2.1


parameters:
  parameter-name-but-can-be-only-one:
    type: string
    default: ''

jobs:
  build-it:
    parameters:
      my-parameter:
        type: string

    steps:
      - run: echo "<< parameters.my-parameter >>"

workflows:
  build-it:
    jobs:
      - my-parameter:
          name: "build << pipeline.parameters.parameter-name-but-can-be-only-one >>"
```

Will result in - if any files (matching that first regex, in this case files in the `regex-we-match-log-lines-against` folder - to echo "value json literal".
