# Bandit CTF Writeups: Levels 13 to 19

This document contains the objectives, terminal commands, and system-level logic for solving levels 0 through 6 of the OverTheWire Bandit wargame.

---

**Host:** `bandit.labs.overthewire.org`
**Port:** `2220`

---


# Bandit Level 13 → 14


* **Goal:** The password for bandit14 is in `/etc/bandit_pass/bandit14`, readable only by bandit14. This level gives you a private SSH key instead of a password.

* **Solution:** 

```bash

ssh bandit13@bandit.labs.overthewire.org -p 2220

 
scp -P 2220 bandit13@bandit.labs.overthewire.org:~/sshkey.private .


ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220


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

openssl s_client -quiet -connect localhost:30001

```


---


# Bandit Level 16 → 17

## Goal
Find a port in range 31000–32000 that speaks SSL/TLS and returns credentials (not just an echo). Submit the current password to it to get an RSA private key for the next level.

## Solution

```bash

nmap -p 31000-32000 -sV localhost



openssl s_client -quiet -connect localhost:31790



nano key17.key

chmod 600 key17.key

ssh -i key17.key bandit17@bandit.labs.overthewire.org -p 2220
```

---

# Bandit Level 17 → 18

## Goal
Two files exist in the home directory: `passwords.old` and `passwords.new`. The password is the only line that changed between them.

## Solution

```bash
diff passwords.old passwords.new
```

---

# Bandit Level 18 → 19

## Goal
Password is in `~/readme` but `.bashrc` has been modified to log you out immediately on SSH login.

## Solution

```bash
ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme
```

> SSH lets you append a command after the connection args. It runs that command instead of starting an interactive session, so the malicious `.bashrc` logout never triggers.

---

# Bandit Level 19 → 20

## Goal
Use a setuid binary in the home directory to read the password for bandit20.

## Solution

```bash
./bandit20-do

./bandit20-do cat /etc/bandit_pass/bandit20
```

