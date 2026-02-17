# Login Shell

When bash is started as a login shell (either interactive or non-interactive),
it does the following:

1. Executes the system startup file `/etc/profile`
2. Executes the _first_ user startup file it finds:
   a. `~/.bash_profile`
   b. `~/.bash_login`
   c. `~/.profile`

The `--noprofile` option prevents both steps above.

# Non-login Interactive Shell

When bash is started as a non-login shell that is interactive, it executes
`~/.bashrc`.

The `--norc` option prevents this.
The `--rcfile file` specifies a different file to be executed instead of
`~/.bashrc`.

# When Login Shell Exits

When a login bash shell exits, it executes `~/.bash_logout`
