# mba-provisioner2
My PC (M1 MacBook Air) provisioner  
since [my previous "mba-provisioner"](https://github.com/sogaoh/mba-provisioner)

## Prerequisite

### OS
- macOS Big Sur ~  (zsh)
  - MacBook Air (M1,2020)

### Security
- **Allow full access to terminal.app**
    - System Environment Settings -> Security & Privacy 

### Install
- Install Homebrew (refs https://brew.sh/)
  ```zsh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- Install Ansible
  ```zsh
  brew update
  brew install ansible
  ```

- Install Rosetta (refs https://support.apple.com/HT211861)


### Prepare
- Clone this repository
  ```zsh
  git clone https://github.com/sogaoh/mba-provisioner2.git
  ```

- Set `variables.yaml` (If run `make ma`)
  ```
  mackerel_agent_apikey: "<your_key>"
  ```

- Create `/etc/hosts` symbolic link [optional]
  ```zsh
  sudo mv /private/etc/hosts /private/etc/hosts.org
  touch ~/.config/hosts
  sudo ln -snf ~/.config/hosts /private/etc/hosts
  ``` 
