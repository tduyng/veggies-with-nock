NODE_MODULES     = ./node_modules
NODE_MODULES_BIN = $(NODE_MODULES)/.bin

########################################################################################################################
#
# HELP
#
########################################################################################################################

# COLORS
RED    = $(shell printf "\33[31m")
GREEN  = $(shell printf "\33[32m")
WHITE  = $(shell printf "\33[37m")
YELLOW = $(shell printf "\33[33m")
RESET  = $(shell printf "\33[0m")

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
# A category can be added with @category
HELP_HELPER = \
    %help; \
    while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-\%]+)\s*:.*\#\#(?:@([a-zA-Z\-\%_]+))?\s(.*)$$/ }; \
    print "usage: make [target]\n\n"; \
    for (sort keys %help) { \
    print "${WHITE}$$_:${RESET}\n"; \
    for (@{$$help{$$_}}) { \
    $$sep = " " x (32 - length $$_->[0]); \
    print "  ${YELLOW}$$_->[0]${RESET}$$sep${GREEN}$$_->[1]${RESET}\n"; \
    }; \
    print "\n"; }

help: ##prints help
	@perl -e '$(HELP_HELPER)' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


########################################################################################################################
#
# Check
#
########################################################################################################################

ok: ##@check run linters formatting check and test on all packages
	@$(MAKE) fmt-check
	@$(MAKE) lint
	@echo "$(GREEN)✔ everything's fine!${RESET}"

fmt-check: ##@check check if files were all formatted using prettier
	@echo "$(YELLOW)Checking formatting:$(RESET)"
	@$(NODE_MODULES_BIN)/prettier --list-different \
        "**/*.{js,ts}"
	@echo "$(GREEN)✔ well done!${RESET}"
	@echo ""

lint: ##@check lint all files
	@echo "$(YELLOW)Running linter:$(RESET)"
	@$(NODE_MODULES_BIN)/eslint --fix \
        "**/*.{js,ts}"
	@echo "$(GREEN)✔ well done!${RESET}"
	@echo ""

fmt: ##@check format code using prettier
	@echo "$(YELLOW)Formatting packages:$(RESET)"
	@$(NODE_MODULES_BIN)/prettier --color --write \
        "**/*.{js,ts}"


########################################################################################################################
#
# Test
#
########################################################################################################################

test-func: ##@test Run functional test. To add args to veggies, use args env var. 'args="--tags @tag1 --tags @tag2". ex: make test-func args="--tags @offline"'
	@echo "$(YELLOW)Running functional tests:$(RESET)"
	@$(NODE_MODULES_BIN)/veggies --require tests/functional/support tests/functional/features ${args}
