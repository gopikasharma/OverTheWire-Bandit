# Bandit CTF Writeups: Levels 27 to 33

OverTheWire Bandit wargame solutions — objectives, commands, and notes.

**Host:** `bandit.labs.overthewire.org` | **Port:** `2220`

---

## Level 27 → 28

Clone the repository and read the README.

```bash
git clone ssh://bandit27-git@bandit.labs.overthewire.org:2220/home/bandit27-git/repo
cd repo
cat README
```

---

## Level 28 → 29

The password was redacted in a later commit. Check the full diff history.

```bash
git clone ssh://bandit28-git@bandit.labs.overthewire.org:2220/home/bandit28-git/repo
cd repo
git log -p
```

`git log -p` shows every commit's diff, including lines that were removed — where the password was.

---

## Level 29 → 30

The password isn't on `master`. List all branches and check `dev`.

```bash
git clone ssh://bandit29-git@bandit.labs.overthewire.org:2220/home/bandit29-git/repo
cd repo
git branch -a
git checkout dev
git log -p
```

---

## Level 30 → 31

No useful history, no extra branches. The password is stored in a git tag.

```bash
git clone ssh://bandit30-git@bandit.labs.overthewire.org:2220/home/bandit30-git/repo
cd repo
git tag
git show secret
```

---

## Level 31 → 32

Push a file to the remote repo. `.gitignore` blocks `*.txt`, so force-add it.

```bash
git clone ssh://bandit31-git@bandit.labs.overthewire.org:2220/home/bandit31-git/repo
cd repo
echo 'May I come in?' > key.txt
git add -f key.txt
git commit -m "add key.txt"
git push origin master
```

The password is returned by the server in the push output, not stored in the repo.

---

## Level 32 → 33

The shell converts all input to uppercase before executing, so normal commands fail. Shell variable expansion happens before the uppercase transform — `$0` expands to the current shell name and spawns a new `sh` session.

```bash
$0
cat /etc/bandit_pass/bandit33
```