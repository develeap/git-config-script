# git-config-script

[![License](https://img.shields.io/badge/license-Apache--2.0-green)](https://opensource.org/license/apache2-0/)
[![ShellCheck](https://github.com/develeap/git-config-script/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/develeap/git-config-script/actions/workflows/shellcheck.yml)

This script helps setup git for a new install. When installing git, you get several warnings about settings you need to configure, including setting a username, an email address and a default branch name. To avoid these warnings, it is needed to set global settings that would be used by default for each repo. In addition, it is recommended to set a GPG or SSH key that will be used for signing commits. I wrote a shell script to help with this process.

This script does the following:
  - configures global git.user (according to user input).
  - configures global git.email (according to user input).
  - configures "main" as the default branch name.
  - Generates a new SSH key and configures it to be used as the global Signing Key for git.
  - Shows instructions for adding the SSH Key to GitHub and other git providers (GitLab, Codeberg, Gitea, Forgejo and Gogs).

After running this script, your `~/.gitconfig` file should look similar to [.gitconfig.sample](https://github.com/develeap/git-config-script/blob/main/.gitconfig.sample).

## FAQ - Frequently Asked Questions
### How do I run this script?
Ths script can be run with the following command:  
`/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/develeap/git-config-script/main/shell-script/git-config.sh)"`  
Make sure to run it on your own user since it needs access to your HOME folder. Do not run this script as root/sudo/doas.

### Which platforms are supported?
All Unix platforms that support recent-enough versions of git and OpenSSH should work, including modern Linux distros, macOS and WSL.

### I don't want to run random shell scripts from GitHub.
This is understandable. I encourage every user to understand what *any* shell script does before blindly running it. This script is open-source; you can read its source code to see what it does, and judge for yourself if you want to run it. For this script, root access is not required nor wanted.

### Is this script really necessary? I can do all this on my own.
It is true that you can achieve the same results just by running a few commands. All this script really does is generate an SSH key and edits your `~/.gitconfig`. However, after doing this process many times across different git installs, I decided to automate it with this script.


### Resources
To read more about what this script does and related topics, have a look at these resources:
  - Git Documentation
    + [git-config](https://git-scm.com/docs/git-config)
    + [Generating Your SSH Public Key](https://git-scm.com/book/en/v2/Git-on-the-Server-Generating-Your-SSH-Public-Key)
    + [Git Tools - Signing Your Work](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work)

  - GitHub Documentation
    + [Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
    + [Managing commit signature verification](https://docs.github.com/en/authentication/managing-commit-signature-verification)
    + [Troubleshooting SSH](https://docs.github.com/en/authentication/troubleshooting-ssh)

  - GitLab Documentation
    + [Use SSH keys to communicate with GitLab](https://docs.gitlab.com/ee/user/ssh.html)
    + [Sign commits with SSH keys](https://docs.gitlab.com/ee/user/project/repository/ssh_signed_commits/)
    + [Sign commits with GPG](https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/)

  - Codeberg Documentation
    + [Adding an SSH key to your account](https://docs.codeberg.org/security/ssh-key/)
    + [Verifying you're connected to Codeberg using SSH fingerprints](https://docs.codeberg.org/security/ssh-fingerprint/)
    + [Adding a GPG key to your account](https://docs.codeberg.org/security/gpg-key/)
