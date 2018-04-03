PATTERNS=pass
ALLOWED=@font-face{.*}\
password\
test\
test-pull
LITERALS=passwords\
literal

# color output
NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m

OK_STRING=$(OK_COLOR)[OK]$(NO_COLOR)
ERROR_STRING=$(ERROR_COLOR)[ERRORS]$(NO_COLOR)
WARN_STRING=$(WARN_COLOR)[WARNINGS]$(NO_COLOR)

AWK_CMD = awk '{ printf "%-30s %-10s\n",$$1, $$2; }'
PRINT_LINE = printf "%0.s*" {1..50} && printf "\n"
PRINT_ERROR = printf "$(ERROR_COLOR)$@ $(ERROR_STRING)\n" | $(AWK_CMD) && printf "$(CMD)\n$$LOG\n" && false && $(PRINT_LINE)
PRINT_WARNING = printf "$(WARN_COLOR)$@ $(WARN_STRING)\n" | $(AWK_CMD) && $(PRINT_LINE)
PRINT_OK = printf "$(OK_COLOR)$@ $(OK_STRING)\n" | $(AWK_CMD) && $(PRINT_LINE)

full-setup: ../.git/config
	@$(MAKE) setup-aws
	@$(MAKE) add-patterns
	@$(MAKE) add-allowed
	@$(MAKE) add-literals

setup-aws: ../.git/config
	@cd .. && git secrets --register-aws || echo "SETUP ALREADY DONE"
	@$(PRINT_OK)
	
add-patterns: ../.git/config
ifdef PATTERNS
	@cd .. && $(foreach var,$(PATTERNS),git secrets --add $(var)\
	&& echo "$(var) HAS BEEN ADDED"\
	|| echo "$(var) ALREADY ADDED";)
	@$(PRINT_OK)
endif
	
add-allowed: ../.git/config
ifdef ALLOWED
	@cd .. && $(foreach var,$(ALLOWED),git secrets --add -a $(var)\
	&& echo "$(var) HAS BEEN ADDED"\
	|| echo "$(var) ALREADY ADDED";)
	@$(PRINT_OK)
endif

add-literals: ../.git/config
ifdef LITERALS
	@cd .. && $(foreach var,$(LITERALS),git secrets --add -a --literal $(var)\
	&& echo "$(var) HAS BEEN ADDED"\
	|| echo "$(var) ALREADY ADDED";)
	@$(PRINT_OK)
endif

list: ../.git/config
	@cd .. && git secrets --list