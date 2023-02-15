#!/bin/sh

main() {
    DEFAULT_BRANCH="main"
    SSH_HOST_KEY_ALGO="ed25519"

    USER_NAME=""    # can use your GitHub username (or another git provider)
    USER_EMAIL=""   # Must be a valid email address (can use noreply)
    SSH_KEY_NAME="" # Path: "${HOME}/.ssh/${SSH_KEY_NAME}"

    choose_values   # optionally disable this function and instead set the values above manually

    configure_values
    ssh_key_message
}

configure_values() {
    printf "\n"
    new_ssh_key

    git config --global init.defaultBranch "${DEFAULT_BRANCH}"
    git config --global user.name "${USER_NAME}"
    git config --global user.email "${USER_EMAIL}"
    git config --global gpg.format ssh
    git config --global user.signingkey ~"/.ssh/${SSH_KEY_NAME}"
    git config --global commit.gpgsign true

    printf "\n\n"
    echo "git config values set!"
}

new_ssh_key() {
    mkdir -p "${HOME}/.ssh"
    echo "ssh-keygen -t ${SSH_HOST_KEY_ALGO} -C ${USER_EMAIL} -f ${HOME}/.ssh/${SSH_KEY_NAME}"
    ssh-keygen -t "${SSH_HOST_KEY_ALGO}" -C "${USER_EMAIL}" -f "${HOME}/.ssh/${SSH_KEY_NAME}"
}

ssh_key_message() {
    printf "\n"
    printf "Print SSH public key? (y/N)? "
    read -r answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        echo "SSH public key \"${HOME}/.ssh/${SSH_KEY_NAME}.pub\" value is:"
        cat "${HOME}/.ssh/${SSH_KEY_NAME}.pub"
    fi

    printf "\n"
    echo "Please add your SSH public key to your git provider.
Make sure to add the same public SSH key both as an Authentication Key and as a Signing Key.
In GitHub, add it under \`Settings > SSH and GPG Keys > New SSH key\`.
In GitLab, add it under \`Preferences > SSH Keys > Key\`.
In Codeberg/Gitea/Forgejo/Gogs, add it under \`Settings > SSH / GPG Keys > Add Key\`.
"
}

choose_values() {
    # shellcheck disable=SC3043
    local valid_values=false
    while [ ${valid_values} = false ]; do
        printf "\n"
        printf "Choose git user.name (can use your GitHub username): " >&2
        read -r USER_NAME
        # printf '%s\n' "${USER_NAME}"

        # shellcheck disable=SC3043
        local valid_email=false
        while [ ${valid_email} = false ]; do
            printf "\n"
            printf "Choose git user.email (can use noreply): " >&2
            read -r USER_EMAIL
            # printf '%s\n' "${USER_EMAIL}"

            if printf '%s\n' "${USER_EMAIL}" | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b"; then
                # echo "Proper email address detected ${USER_EMAIL}"
                valid_email=true
            else
                echo "Email address \"${USER_EMAIL}\" is invalid."
                valid_email=false
            fi
        done

        printf "\n"
        printf "Choose SSH key name: " >&2
        read -r SSH_KEY_NAME
        # printf '%s\n' "${SSH_KEY_NAME}"

        if [ -f "${HOME}/.ssh/${SSH_KEY_NAME}" ]; then
            printf "\n"
            echo "Warning: SSH key \"${SSH_KEY_NAME}\" already exists at ${HOME}/.ssh"
        else
            true
        fi

        printf "\n"
        echo "Your chosen values are:"
        echo "user.name: ${USER_NAME}"
        echo "user.email: ${USER_EMAIL}"
        echo "SSH path: ${HOME}/.ssh/${SSH_KEY_NAME}"

        printf "\n"
        printf "Are these the values you want to set in your git config? (y/N)? "
        read -r answer
        if [ "$answer" != "${answer#[Yy]}" ]; then
            echo Yes
            valid_values=true
        else
            echo No
            valid_values=false
        fi
    done
}

main

exit 0
