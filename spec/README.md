# Running tests

```bash
$ rake app:db:setup
$ rake app:db:test:prepare
$ rake
```

## Folders

```bash
spec/dummy/app             # dummy app for generating chili features inside
spec/dummy/blank_feature   # blank feature template used to compare output of generators
spec/example_app           # rails app containing 2 chili features for integration testing
spec/generators            # generator tests
spec/lib                   # lib unit tests
spec/requests              # integration tests
```
