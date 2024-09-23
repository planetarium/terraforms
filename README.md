## Development

### Setup Git hooks

```
git config core.hooksPath hooks
```

Since the `pre-commit` hook validates Terraform styles, syntax at all, you may want to bypass it sometimes.

```sh
git --no-verify commit
```
