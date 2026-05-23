# Bandit CTF Writeups: Levels 13 to 19

This document contains the objectives, terminal commands, and system-level logic for solving levels 0 through 6 of the OverTheWire Bandit wargame.

---

**Host:** `bandit.labs.overthewire.org`
**Port:** `2220`

---

# Bandit Level 20 → 21

## Goal
Use a setuid binary `suconnect` that connects to a port you specify, reads a password, and if it matches bandit20's password, sends back bandit21's password.

## Solution

```
echo "[REDACTED]" | nc -l -p 4444 &

./suconnect 4444
```

---

# Bandit Level 21 → 22

## Goal
A cron job is running periodically as bandit22. Find what it does and use it to get the password.

## Solution

```
# 1. Check what cron jobs exist
ls -la /etc/cron.d/

# 2. Read the bandit22 cron job
cat /etc/cron.d/cronjob_bandit22
# → runs /usr/bin/cronjob_bandit22.sh every minute as bandit22

# 3. Read the script
cat /usr/bin/cronjob_bandit22.sh
# → copies bandit22's password to a world-readable /tmp file

# 4. Read that file
cat /tmp/[REDACTED]
```

## Concept
Cron runs scripts on a schedule. The script runs as bandit22 and writes the password to a `/tmp` file with `chmod 644` (world-readable). You just need to find and read that file.

---

# Bandit Level 22 → 23

## Goal
A cron job runs as bandit23 and writes the password to a `/tmp` file named after an md5 hash. Figure out the filename and read it.

## Solution

```bash
# 1. Read the cron job script
cat /usr/bin/cronjob_bandit23.sh
# → mytarget=$(echo I am user $myname | md5sum | cut -d ' ' -f 1)
# → writes password to /tmp/$mytarget

# 2. Reproduce the hash as bandit23 (substitute the username manually)
echo I am user bandit23 | md5sum | cut -d ' ' -f 1
# → [REDACTED]

# 3. Read that file
cat /tmp/[REDACTED]
```

## Concept
The script generates the tmp filename dynamically using `whoami` piped through md5sum. Since you can read the script, you can reproduce the exact command with `bandit23` hardcoded to get the filename.

> **Pitfall:** `echo I am user $bandit23` (with `$` before the name) expands to nothing — you need `bandit23` as a plain string, not a variable.