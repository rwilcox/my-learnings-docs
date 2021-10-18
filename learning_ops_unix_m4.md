---
path: /learnings/ops_unix_m4
title: 'Learnings: Ops: Unix: M4'
---
# Table Of Contents

<!-- toc -->

- [Defining a variable then using it elsewhere multiple times in the file](#defining-a-variable-then-using-it-elsewhere-multiple-times-in-the-file)

<!-- tocstop -->

# Defining a variable then using it elsewhere multiple times in the file


	changequote(`“', `”')

	define(“USER_STRUCTURE”, ““
			+ email: test@example.com (string, optional)
			+ ID: Leeloo@planetexpress.int (string, required) - The ID of the object (use this to make further queries about the object in question). In AD partiance, the userPrincipalName
	””)

	USER_STRUCTURE
	USER_STRUCTURE


Would give us that `+ email` thing TWICE

