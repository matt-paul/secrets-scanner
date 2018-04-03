# Git Secrets Setup

Using git-secrets(https://github.com/awslabs/git-secrets), which is used to scan the repo for secrets.
However, the base installation overrides preexisting git hooks and has no base rules regarding secrets to scan for.
Here we are extending git-secrets to auto setup to a predetermined specification (set here in this repo) and allow for use in other git hook modules e.g. pre-git.


## Summary

 * [Getting Git Secrets](#getting-git-secrets)
 * [Adding Git Secrets to your project](#adding-git-secrets-to-your-project)
 * [Setting up to scan](#setting-up-to-scan)
 * [Scanning for secrets](#scanning-for-secrets)
 * [Adding patterns, allowed patterns and allowed literals](#Adding-patterns-allowed-patterns-and-allowed-literals)


## Getting Git Secrets

1. 	Install Git Secrets.

	```bash
	brew install git-secrets
	```


## Adding Git Secrets to your project

1.  In your project's repository, add the following commands to your `Makefile`, customizing
	them as needed.

	```make
	scanner: ## Initialize git secrets in the scanner folder
		git clone git@github.com:ksunandp/secrets-scanner.git scanner
		@echo ""
		@echo "*************************************************************"
		@echo "* Follow the instructions to get added to the blackbox admins:"
		@echo "* https://github.com/ksunandp/secrets-scanner/blob/master/README.md"
		@echo "*************************************************************"
		@echo ""
		@read -p "Press any key to continue."

    setup-scanner: ## Setup git secrets with stored configuration
	    @cd secrets-scan && git pull
	    @cd secrets-scan && $(MAKE) full-setup

    scan-secrets: ## Scan for secrets
        @git secrets --scan
	```

3.	Add the folder `scanner` to your `.gitignore`.


## Setting up to scan

1.  In your project's repository, clone this repository

    ```bash
    make scanner
    ```

2.  Begin the setup, this will alter .git/config on your repository

    ```bash
    make setup-scanner
    ```


## Scanning for secrets

1.  In your project's repository, you can simple scan as needed

    ```bash
    make scan-secrets
    ```

2.  You can also add this to your git hooks to scan pre-commit (recommended)


## Adding patterns, allowed patterns and allowed literals

These are all held within this repository, until a more dynamic approach has been implemented. Please clone, branch and request pulls.