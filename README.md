# wsl-setup-for-devops
a simple script to install and config apps on Ubuntu

## Directory structure
- setup.sh            - main script
- scripts/apps.sh     - instal apps
- scripts/config.sh   - config apps
- scripts/data.sh     - data for config apps

## Install WSL:
- https://learn.microsoft.com/en-us/windows/wsl/install
- https://learn.microsoft.com/en-us/windows/wsl/basic-commands

```
# check status
wsl --status

# list available Linux distributions
wsl --list --online

# list installed Linux distributions
wsl --list --verbose

# install
wsl --install -d <DistributionName>

# shutdown all distributions
wsl --shutdown

# terminate/shutdown a distribution
wsl --terminate <DistributionName>

# uninstall distro
wsl --unregister <DistributionName>
```

## Install wsl-setup-for-devops:
```
git clone https://github.com/ledoantruc/wsl-setup-for-devops.git
chmod -R 700 wsl-setup-for-devops/
cd wsl-setup-for-devops
./setup.sh
```