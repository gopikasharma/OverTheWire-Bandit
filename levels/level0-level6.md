# Bandit CTF Writeups: Levels 0 to 6

OverTheWire Bandit wargame solutions — objectives, commands, and notes.

**Host:** `bandit.labs.overthewire.org` | **Port:** `2220`

---

## Level 0 — Initial Connection

Connect to the game server using SSH on a non-standard port.

```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
```

---

## Level 0 → 1

Read the password from a file named `readme` in the home directory.

```bash
cat readme
```

---

## Level 1 → 2

Read a file named `-`. Using just `cat -` is interpreted as stdin, so prefix with `./`.

```bash
cat ./-
```

---

## Level 2 → 3

Read a file with spaces in its name.

```bash
cat "./spaces in this filename"
```

---

## Level 3 → 4

Find and read a hidden file inside the `inhere` directory.

```bash
ls -la inhere
cat inhere/.hidden
```

---

## Level 4 → 5

Find the one human-readable file among several binary files in `inhere`.

```bash
cd inhere
file ./*
cat ./<human-readable file>
```

---

## Level 5 → 6

Find a file that is human-readable, exactly 1033 bytes, and not executable.

```bash
find . -type f -size 1033c ! -executable
```

`-size 1033c` matches exactly 1033 bytes (`c` = characters). `! -executable` excludes files with execute permissions.

---

## Level 6 → 7

Find a file anywhere on the server owned by user `bandit7`, group `bandit6`, and exactly 33 bytes.

```bash
find / -user bandit7 -group bandit6 -size 33c 2>/dev/null
```

`2>/dev/null` suppresses permission-denied errors from directories you can't access, leaving only the result.