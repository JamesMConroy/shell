# Shell Libraries & Scripts
This is meant as a repository of helpful POSIX-compliant shell scripts
and libraries (and maybe a modulino or two as well) that can be useful
for learning purposes as well as for bolstering the capabilities of your
shell scripts with adaptive logging interfaces, lesser known capabilities,
and some pre-made potentially useful tools.

## License
All code in this repo is available under the BSD-3 license,
see the LICENSE file for full details.

## Why
Because in the course of doing ${DAYJOB} I've come across many scripts that
are relied upon for business critical functions that either don't have any
coherent design, a heavy reliance on hard-coded assumptions (sometimes OK, but
still not ideal), extremely inefficient pipelines (e.g. Finding a PID by name using
`IMG_PID="$(ps auwwx | grep "${PROCNAME}" | grep -v grep | head -1 | awk '{print $2};')"`),
and heavy reliance on options like `set -e` and `set -o pipefail` in lieu of more
reasonable error handling capable of more informative logging as well as potential
error recovery.

I've also been mentoring coworkers and reviewing some of the study materials they've been using,
finding them to be of dubious quality due to things like exposure to useful constructs
and features, while still using wasteful pipelines, presenting opinion as fact,
poor control flow, and generally inconsistent design without providing any rationale
for why things are done the way they are.

### Books to **NOT** Learn From
* "Wicked Cool Shell Scripts, 2nd Edition", ISBN-13: 978-1-59327-602-7
	- Better than literally nothing
	- Literally none of the scripts in this book would pass my code review
	- Some scripts showcase interesting capabilities, but do not appear to mention
	  when tools already exist to accomplish a given goal, such as iterating over the output
	  of `ps(1)` to find a PID by name instead of `pgrep(1)`
	- Several times personal opinion or simple misinformation is presented as fact (e.g.
	  `printf(1)` is not to just re-implement `echo` from GNU `bash(1)`, just because
	  MacOS ships old userland tools doesn't mean that BSD `date(1)` is deficient compared to
	  GNU `date(1)`, and because it's so commonly stated XNU/Darwin or "MacOS" is **NOT** based
	  on "BSD Unix"!)
