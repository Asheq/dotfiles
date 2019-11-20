# When sh starts as a login shell (whether interactive or non-interactive), it
# executes ~/.profile.

# WARNING: If you delete .bash_profile, this file becomes part of bash's startup
# sequence, which means this file suddenly has to cater for two different
# shells.

. ~/.sh/env
. ~/.sh/login

# TODO: Verify the startup order for sh shell
# TODO: Do we also need to check if sh is being started as an interactive shell
# here, and if so, execute ~/.sh/interactive here?
