## Development

### Setup Git hooks

```
git config core.hooksPath hooks
```

Since `pre-commit` validates Terraform styles, syntax at all, there is a flag to bypass them.

```sh
BYPASS_PRE_COMMIT="true" git commit
```
