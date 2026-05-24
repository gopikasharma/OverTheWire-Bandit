# Bandit CTF Writeups: Levels 27 - 33

**Host:** `bandit.labs.overthewire.org`  
**Port:** `2220`

---

# Bandit Level 27 → 28

## Goal
Clone a git repository and find the password inside it.

## Solution

```bash
git clone ssh://bandit27-git@bandit.labs.overthewire.org:2220/home/bandit27-git/repo
cd repo
cat README
```

---


# Bandit Level 28 → 29

## Goal
Clone a git repository. The password has been redacted in the latest commit — find it in the git history.

## Solution

```bash
git clone ssh://bandit28-git@bandit.labs.overthewire.org:2220/home/bandit28-git/repo
cd repo
cat README.md
git log -p
```


----

# Bandit Level 29 → 30

## Goal
Clone a git repository. The password isn't in the main branch — check other branches.

## Solution

```bash
git clone ssh://bandit29-git@bandit.labs.overthewire.org:2220/home/bandit29-git/repo
cd repo
cat README.md
git branch -a
git checkout dev
git log -p
```
---

# Bandit Level 30 → 31

## Goal
Clone a git repository. No useful history, no extra branches — the password is hidden in a git tag.

## Solution

```bash
git clone ssh://bandit30-git@bandit.labs.overthewire.org:2220/home/bandit30-git/repo
cd repo
git tag
git show secret
```

---

# Bandit Level 31 → 32

## Goal
Push a specific file to the remote repository. The catch: `.gitignore` blocks `*.txt` files.

## Solution

```bash
git clone ssh://bandit31-git@bandit.labs.overthewire.org:2220/home/bandit31-git/repo
cd repo
cat README.md
cat .gitignore
echo 'May I come in?' > key.txt
git add -f key.txt
git commit -m "add key.txt"
git push origin master
```

---

# Bandit Level 32 → 33

## Goal
Escape an "uppercase shell" that converts all input to uppercase before executing it, making normal commands fail.

## Solution

```bash
$0
cat /etc/bandit_pass/bandit33
```

## Concept
The uppercase shell converts everything you type to uppercase, so `ls` becomes `LS`, `cat` becomes `CAT` — all fail with "Permission denied". However, special shell variables like `$0` are expanded *before* the uppercasing happens. `$0` holds the name of the current shell, so typing `$0` spawns a new `sh` session, escaping the uppercase restriction.
