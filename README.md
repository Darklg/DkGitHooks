# DkGitHooks

This shell tool allow you to easily generate some custom git hooks. And it works offline.

## Features list

### Before commit (pre-commit) :

- Check for added debug functions like console.log or var_dump staged for commit. The removed ones are not detected.
- Check for edited core files in WordPress & Magento (like in app/code/core or wp-admin).

## How to use it

Launch this command at the root of your project (adapt with your clone path)

`. ~/websites/htdocs/DkGitHooks/install-hooks.sh`

The tool will ask you for some commit hooks. Then, you can customize the called functions inside each hook file (in .git/hooks) !

## How to install

Just clone this repository !

## TODO

- [ ] Install this repository with a one line command (and a copy to /usr/local/bin)
- [ ] Option to make copy of files rather than references.
- [ ] Load custom checks in "prevent-debug-functions.sh".
- [x] Check invalid path (edition of core WordPress/Magento files).
