#!/bin/bash
# Here goes everything, that should be done while building a dev-container

set -e

# Sanity checks
if [ "$(id -u)" -ne 0 ]; then
  echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
  exit 1
fi

# Install packages
apt-get update -yqq &&
  apt-get install -yqq \
    zsh \
    sudo

# Update or create user

USERNAME="developer"
# TODO: get ids from env
USER_UID=1000
USER_GID=1000
group_name="${USERNAME}"

if id -u ${USERNAME} >/dev/null 2>&1; then
  # User exists, update if needed
  if [ "$USER_GID" != "$(id -g $USERNAME)" ]; then
    group_name="$(id -gn $USERNAME)"
    groupmod --gid $USER_GID ${group_name}
    usermod --gid $USER_GID $USERNAME
  fi
  if [ "$USER_UID" != "$(id -u $USERNAME)" ]; then
    usermod --uid $USER_UID $USERNAME
  fi
elif id -u ${USER_UID} >/dev/null 2>&1; then
  # User Id exists with other name
  groupmod --new-name ${USERNAME} $(id -gn ${USER_GID})
  usermod --login ${USERNAME} --move-home --home /home/${USERNAME} $(id -un ${USER_UID})
else
  # Create user
  groupadd --gid $USER_GID $USERNAME
  useradd -s /bin/bash --uid $USER_UID --gid $USERNAME -m $USERNAME
fi
