# git-config-script

This script helps setup git for a new install. When installing git, you get several warnings about settings you need to configure, including setting a username, an email address and a default branch name. To avoid these warnings, it is needed to set global settings that would be used by default for each repo. In addition, it is recommended to set a GPG or SSH key that will be used for signing commits. I wrote a shell script to help with this process.

This script does the following:
  - configures global git.user (according to user input).
  - configures global git.email (according to user input).
  - configures "main" as the default branch name.
  - Generates a new SSH key and configures it to be used as the global Signing Key for git.
  - Shows instructions for adding the SSH Key to GitHub and other git providers (GitLab, Codeberg, Gitea, Forgejo and Gogs).
