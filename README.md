# Git Secrets Setup

Using git-secrets(https://github.com/awslabs/git-secrets), which is used to scan the repo for secrets.
However, the base installation overrides preexisting git hooks and has no base rules regarding secrets to scan for.
Here we are extending git-secrets to auto setup to a predetermined specification (set here in this repo) and allow for use in other git hook modules e.g. pre-git.


## Summary

 * [Getting Git Secrets](#getting-git-secrets)


## Getting Git Secrets

1. 	Install Git Secrets.

	```bash
	brew install git-secrets
	```
