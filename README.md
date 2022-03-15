Eventually I'm going to turn this documentation page into some kind of [Gatsby](https://www.gatsbyjs.com/) enabled static site.

If you're looking at this repo directly, that day is not today.

# Technologies used here

The first approach for this site is to use Github as a (decent!) markdown rendering platform for individual files.

Some files are preprocessed via [Racket's scribble library](https://docs.racket-lang.org/scribble/index.html) documentation tool. Then I checkin / commit the generated files so they are viewed via its rendered Github generated markdown

# TODO:

- [x] generate ToCs for those super long pages...
- [ ] my refenence backlink stuff doesn't work with markdown-toc <-- ends up coming out as `>` in the reference. Boo.


# File Index

Because if you're looking at the file list in Github, it's hard to know if a file is the (good to view / generated one) vs the Scribble pre-processed slightly messy original file. It looks like it shows up twice...

  * [README.md](https://github.com/rwilcox/my-learnings-docs/blob/master/README.md)
  * [book_notes_ask_your_developer.md](https://github.com/rwilcox/my-learnings-docs/blob/master/book_notes_ask_your_developer.md)
  * [book_notes_devops_handbook.md](https://github.com/rwilcox/my-learnings-docs/blob/master/book_notes_devops_handbook.md)
  * [book_notes_phoenix_project.md](https://github.com/rwilcox/my-learnings-docs/blob/master/book_notes_phoenix_project.md)
  * [book_notes_seeing_organizational_patterns.md](https://github.com/rwilcox/my-learnings-docs/blob/master/book_notes_seeing_organizational_patterns.md)
  * [book_notes_slack.md](https://github.com/rwilcox/my-learnings-docs/blob/master/book_notes_slack.md)
  * [book_notes_unicorn_project.md](https://github.com/rwilcox/my-learnings-docs/blob/master/book_notes_unicorn_project.md)
  * [learning_akka.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_akka.md)
  * [learning_angular.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_angular.md)
  * [learning_applescript_snippets.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_applescript_snippets.md)
  * [learning_aws.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_aws.md)
  * [learning_aws_cloudformation.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_aws_cloudformation.md)
  * [learning_aws_ecs.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_aws_ecs.md)
  * [learning_c#.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_c#.md)
  * [learning_cassandra.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_cassandra.md)
  * [learning_ddd.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ddd.md)
  * [learning_docker.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_docker.md)
  * [learning_emacs_cheatsheet.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_emacs_cheatsheet.md)
  * [learning_emacs_lsp_rust.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_emacs_lsp_rust.md)
  * [learning_emacs_shell_interactions.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_emacs_shell_interactions.md)
  * [learning_functional_programming.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_functional_programming.md)
  * [learning_gatsbyjs.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_gatsbyjs.md)
  * [learning_git.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_git.md)
  * [learning_google_cloud.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_google_cloud.md)
  * [learning_gradle.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_gradle.md)
  * [learning_graph_database_gremlin_tinkerpop.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_graph_database_gremlin_tinkerpop.md)
  * [learning_graph_database_janusgraph.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_graph_database_janusgraph.md)
  * [learning_graphql.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_graphql.md)
  * [learning_helm.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_helm.md)
  * [learning_java.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java.md)
  * [learning_java_bytecode.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_bytecode.md)
  * [learning_java_concurrency.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_concurrency.md)
  * [learning_java_development_environment_setup.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_development_environment_setup.md)
  * [learning_java_generics.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_generics.md)
  * [learning_java_gotchas.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_gotchas.md)
  * [learning_java_http_clients.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_http_clients.md)
  * [learning_java_jaxrs.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_jaxrs.md)
  * [learning_java_jmx_jmxmp.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_jmx_jmxmp.md)
  * [learning_java_junit_mockito.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_junit_mockito.md)
  * [learning_java_lambdas.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_lambdas.md)
  * [learning_java_maven.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_maven.md)
  * [learning_java_memory.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_memory.md)
  * [learning_java_rxjava.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_rxjava.md)
  * [learning_java_spring.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_spring.md)
  * [learning_java_spring_security.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_java_spring_security.md)
  * [learning_javascript_cool_snippets.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_cool_snippets.md)
  * [learning_javascript_eslint.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_eslint.md)
  * [learning_javascript_flow.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_flow.md)
  * [learning_javascript_flow_generics.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_flow_generics.md)
  * [learning_javascript_gotchas.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_gotchas.md)
  * [learning_javascript_jsdoc.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_jsdoc.md)
  * [learning_javascript_own_packages.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_own_packages.md)
  * [learning_javascript_rxjs.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_rxjs.md)
  * [learning_javascript_security_for_apis.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_security_for_apis.md)
  * [learning_javascript_typescript.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_typescript.md)
  * [learning_javascript_typescript_compiler.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_typescript_compiler.md)
  * [learning_javascript_typescript_configuring_language.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_typescript_configuring_language.md)
  * [learning_javascript_typescript_null_handling_strategies.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_typescript_null_handling_strategies.md)
  * [learning_javascript_typescript_typechecking_with_jsdoc_annotations.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_typescript_typechecking_with_jsdoc_annotations.md)
  * [learning_javascript_unicode_everything_you_never_wanted_to_know.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_javascript_unicode_everything_you_never_wanted_to_know.md)
  * [learning_jenkins.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_jenkins.md)
  * [learning_journald.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_journald.md)
  * [learning_kafka_notes.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_kafka_notes.md)
  * [learning_kotlin.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_kotlin.md)
  * [learning_kubernetes.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_kubernetes.md)
  * [learning_machine_learning.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_machine_learning.md)
  * [learning_macports.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_macports.md)
  * [learning_microservices_the_hard_parts_nfjs_training.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_microservices_the_hard_parts_nfjs_training.md)
  * [learning_mongo.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_mongo.md)
  * [learning_my_unix_tools.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_my_unix_tools.md)
  * [learning_operations.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_operations.md)
  * [learning_operations_microservices.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_operations_microservices.md)
  * [learning_operations_sre.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_operations_sre.md)
  * [learning_ops_aws_ecs.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_aws_ecs.md)
  * [learning_ops_docker.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_docker.md)
  * [learning_ops_java.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_java.md)
  * [learning_ops_java_spring.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_java_spring.md)
  * [learning_ops_java_spring_slueth_zipkin.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_java_spring_slueth_zipkin.md)
  * [learning_ops_javascript.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_javascript.md)
  * [learning_ops_kafka.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_kafka.md)
  * [learning_ops_kafka_microservices.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_kafka_microservices.md)
  * [learning_ops_kubernetes.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_kubernetes.md)
  * [learning_ops_networking.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_networking.md)
  * [learning_ops_pets_not_cattle.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_pets_not_cattle.md)
  * [learning_ops_unix_apt.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_unix_apt.md)
  * [learning_ops_unix_bash.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_unix_bash.md)
  * [learning_ops_unix_m4.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_unix_m4.md)
  * [learning_ops_unix_memory_vm.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_unix_memory_vm.md)
  * [learning_ops_unix_misc.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_unix_misc.md)
  * [learning_ops_zookeeper.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_ops_zookeeper.md)
  * [learning_paypal.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_paypal.md)
  * [learning_powershell.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_powershell.md)
  * [learning_python.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_python.md)
  * [learning_rust.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_rust.md)
  * [learning_sbt.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_sbt.md)
  * [learning_scala.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_scala.md)
  * [learning_screen.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_screen.md)
  * [learning_smalltalk.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_smalltalk.md)
  * [learning_splunk.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_splunk.md)
  * [learning_spring_spring_data.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_spring_spring_data.md)
  * [learning_systemd.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_systemd.md)
  * [learning_terraform.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_terraform.md)
  * [learning_time_series_database_druid.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_time_series_database_druid.md)
  * [learning_unix_commands_i_forget.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_unix_commands_i_forget.md)
  * [learning_vault.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_vault.md)
  * [learning_vim.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_vim.md)
  * [learning_vscode.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_vscode.md)
  * [learning_zsh_tricks.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learning_zsh_tricks.md)
  * [learnings_domain_driven_design.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learnings_domain_driven_design.md)
  * [learnings_gtoolkit.md](https://github.com/rwilcox/my-learnings-docs/blob/master/learnings_gtoolkit.md)
  * [synthesis_agile_in_the_enterprise.md](https://github.com/rwilcox/my-learnings-docs/blob/master/synthesis_agile_in_the_enterprise.md)
  * [synthesis_agile_teams.md](https://github.com/rwilcox/my-learnings-docs/blob/master/synthesis_agile_teams.md)
  * [synthesis_career_growth.md](https://github.com/rwilcox/my-learnings-docs/blob/master/synthesis_career_growth.md)
  * [synthesis_management_agile.md](https://github.com/rwilcox/my-learnings-docs/blob/master/synthesis_management_agile.md)
  * [synthesis_managing_agile_teams.md](https://github.com/rwilcox/my-learnings-docs/blob/master/synthesis_managing_agile_teams.md)
  * [synthesis_microservices_in_the_enterprise.md](https://github.com/rwilcox/my-learnings-docs/blob/master/synthesis_microservices_in_the_enterprise.md)
  * [synthesis_microservices_the_tech.md](https://github.com/rwilcox/my-learnings-docs/blob/master/synthesis_microservices_the_tech.md)
  * [synthesis_site_reliability_engineering_sre.md](https://github.com/rwilcox/my-learnings-docs/blob/master/synthesis_site_reliability_engineering_sre.md)
  * [synthesis_software_project_analyisi_across_microservice_herd.md](https://github.com/rwilcox/my-learnings-docs/blob/master/synthesis_software_project_analyisi_across_microservice_herd.md)
  * [synthesis_software_project_analysis.md](https://github.com/rwilcox/my-learnings-docs/blob/master/synthesis_software_project_analysis.md)
  * [synthesis_technical_leadership.md](https://github.com/rwilcox/my-learnings-docs/blob/master/synthesis_technical_leadership.md)
  * [synthesis_technical_project_management_falacies.md](https://github.com/rwilcox/my-learnings-docs/blob/master/synthesis_technical_project_management_falacies.md)
