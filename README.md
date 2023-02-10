# Dotfiles

These are my Fedora / Ubuntu [dotfiles](https://dotfiles.github.io), with built-in post-install scripts.

### About

Dotfiles are an extremely useful way to quickly bootstrap a new system, as with a single command it's possible to automate the process of getting your system just the way you like it. These dotfiles were made largely as a learning project and oriented towards quickly setting up new systems suited for a specific use-case. 

With that out of the way, `bin/dotfiles` is the "dotfiles" command that makes things happen.

## How it works

- Git is installed* if necessary.
- The repository is cloned/updated in ~/ with aforementioned Git.
- Dotfiles sources relevant files inside src/ and vendor/
- `bin/` - Everything here will be added to PATH.
- `link/` - Everything here will be linked to the home directory.
- `copy/` - Everything here will be copied to the home directory.
- `init/` - Everything here will be run once, if appropriate.

When dotfiles is executed, the aforementioned happens by way of magic. Excessively verbose logs are also generated for my viewing pleasure. Ideally, dotfiles is idempotent, so links won't be recreated, copied files won't be overwritten, etc. Realistically, I've probably messed something up already.

*if git isn't installed and can't be installed, dotfiles gets mad and quits.

### About `bin`

It's added to PATH, there really isn't much to it. These may be used by dotfiles itself.

### About `link`

Files inside link/ are symlinked to the same path in ~/. Anything that would be overwritten is copied to `backup/`. If a symlink is detected and already points to the correct file, nothing changes.

### About `copy`

Stuff inside copy/ is recursively copied to ~/. Anything that would be overwritten is copied to `backup/`.

### About `init`

Scripts inside are run depending on the requirements.

### Others

- `backup/` - is generated when linking/copying would overwrite anything.
- `misc/` - misc resources that can be used by dotfiles.
- `vendor/` - third party stuff.

## Installation

### For you

I don't recommend it. Seriously though, you shouldn't install random people's dotfiles, for several reasons.
- I maintain it, so I'll probably break it later.
- It's tailored to my needs, which might differ from yours.
- Wow, this is some bad code. You shouldn't trust whoever made this.

If this repository interests you in any way, I highly suggest searching about dotfiles. There's lots of better dotfiles out there, since this is very much a *learning* project of mine. If you're planning on using someone else's dotfiles, maybe it's worth looking for one that suits you best. 

Alternatively, if you really want to try these out for some reason, fork the repository and look over it carefully. Imagine forgetting to change the gitconfig file and now all your commits have a random guy's name on them. 

### For me

I run this:
```
bash -c "$(wget -qO- https://raw.githubusercontent.com/fmbarina/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

## Inspiration

Heavily inspired by this guy's [very cool dotfiles](https://github.com/cowboy/dotfiles), thanks cowboy. In fact, it might've been easier to just use his, but I don't learn as well without doing things myself.

I'd also like to thank the [dotfiles community](https://dotfiles.github.io) all around for all the amazing dotfiles and guides out there.

## License

MIT License, see LICENSE for more details.
