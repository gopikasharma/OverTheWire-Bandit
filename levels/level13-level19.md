# Bandit CTF Writeups: Levels 13 to 19

OverTheWire Bandit wargame solutions — objectives, commands, and notes.

**Host:** `bandit.labs.overthewire.org` | **Port:** `2220`

---

## Level 13 → 14

The password is in `/etc/bandit_pass/bandit14`, readable only by bandit14. This level gives you a private SSH key instead of a password.

```bash
ssh bandit13@bandit.labs.overthewire.org -p 2220
scp -P 2220 bandit13@bandit.labs.overthewire.org:~/sshkey.private .
ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220
cat /etc/bandit_pass/bandit14
```

---

## Level 14 → 15

Submit the bandit14 password to port 30000 on localhost.

```bash
nc localhost 30000
```

Paste the password and hit Enter. The service responds with the next password.

---

## Level 15 → 16

Submit the current password to port 30001 using SSL/TLS.

```bash
openssl s_client -quiet -connect localhost:30001
```

Port goes in the `-connect host:port` argument — the `-p` flag doesn't work with `s_client`.

---

## Level 16 → 17

Find the one port in range 31000–32000 that speaks SSL and returns credentials rather than echoing input back.

```bash
nmap -p 31000-32000 -sV localhost
openssl s_client -quiet -connect localhost:31790
```

Port 31790 is the only `ssl/unknown` (non-echo) service. Submit the password and save the returned RSA key.

```bash
nano key17.key       # paste the RSA private key
chmod 600 key17.key
ssh -i key17.key bandit17@bandit.labs.overthewire.org -p 2220
```

---

## Level 17 → 18

The password is the only line that differs between `passwords.old` and `passwords.new`.

```bash
diff passwords.old passwords.new
```

---

## Level 18 → 19

`.bashrc` has been modified to log you out on login. Append the command directly to the SSH call to bypass the interactive shell.

```bash
ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme
```

---

## Level 19 → 20

A setuid binary in the home directory runs commands as bandit20.

```bash
./bandit20-do cat /etc/bandit_pass/bandit20
```

The `s` in `-rwsr-x---` is the setuid bit — it runs the binary as its owner (bandit20) regardless of who executes it.