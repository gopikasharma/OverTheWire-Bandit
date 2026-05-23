# Bandit CTF Writeups: Levels 0 to 6

This document contains the objectives, terminal commands, and system-level logic for solving levels 0 through 6 of the OverTheWire Bandit wargame.

---

**Host:** `bandit.labs.overthewire.org`
**Port:** `2220`

---


# Bandit Level 13 → 14


* **Goal:** The password for bandit14 is in `/etc/bandit_pass/bandit14`, readable only by bandit14. This level gives you a private SSH key instead of a password.

* **Solution:** 

```bash
# 1. Login as bandit13
ssh bandit13@bandit.labs.overthewire.org -p 2220

# 2. Copy the private key to your local machine (run this on your local terminal)
scp -P 2220 bandit13@bandit.labs.overthewire.org:~/sshkey.private .

# 3. Login as bandit14 using the key
ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220

# 4. Read the password
cat /etc/bandit_pass/bandit14
```

---


## Level 14 → 15
 
**Objective:** Retrieve the password for `bandit15` by submitting the current level's password to port 30000 on localhost.
 
**What worked:**
```bash
nc localhost 30000
# paste the bandit14 password, then hit Enter
```
 
**Output:**
```
[REDACTED]
Correct!
[REDACTED]
```

-----


 # Bandit Level 15 → 16

## Goal
Submit the current level's password to port 30001 on localhost using SSL/TLS encryption to get the next password.

## Solution
1. SSH into the server: `ssh bandit15@bandit.labs.overthewire.org -p 2220` (and enter the password).



```bash
# Connect using openssl and send the bandit15 password
openssl s_client -quiet -connect localhost:30001
# paste password, hit Enter → receive next password
```

> `-quiet` suppresses certificate output. The cert is self-signed so you'll see a verify error (that's fine, it still works).