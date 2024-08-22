
# What is this?
A repo to manage my dotfiles and basic MacOS setup.

# Pull yourself up by the bootstrap
Use this handy script to put task file into `./bin`

> Never run a script from the internet without checking it first!

```bash
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d
```
Once this is done, the Mac may then be bootstrapped:

```bash
./bin/task bootstrap packages
```

## Installing dotfiles

```bash
./bin/task homemaker
```
## Post install steps

To install tmux plugins enter tmux and install using:

```
Press prefix + I (capital i, as in Install) to fetch the plugin.
```
