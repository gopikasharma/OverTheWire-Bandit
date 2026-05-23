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

```bash

echo "[REDACTED]" | nc -l -p 4444 &

./suconnect 4444


## Concept
`suconnect` runs as bandit21 (setuid). It connects to your listener, reads the password you're serving, validates it, and responds with the next one. The `&` backgrounds the `nc` listener so you can run `suconnect` in the same terminal session.