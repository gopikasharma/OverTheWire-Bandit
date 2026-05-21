# OverTheWire: Bandit - Security Wargames

**Host:** `bandit.labs.overthewire.org`
**Port:** `2220`

## Level 0: The Initial Connection
* **Goal:** Connect to the game server on a non-standard port using SSH.
* **Command:** `ssh bandit0@bandit.labs.overthewire.org -p 2220`


## Level 0 → Level 1
* **Goal:** Read the password stored in a standard text file named `readme`.
* **Command:** `cat readme`

## Level 1 → Level 2
* **Goal:** Read a file named `-` located in the home directory.
* **Command:** `cat ./-`


## Level 2 → Level 3
* **Goal:** Read a file named `spaces in this filename`.
* **Command:** `cat "./--spaces in this filename--"`


## Level 3 → Level 4
* **Goal:** Find and read a hidden file inside the `inhere` directory.
* **Command:** `ls -la` then `cat .hidden`

## Level 4 → Level 5
* **Goal:** Find the one human-readable file among several non-readable data files in the `inhere` directory.
* **Command:** `cd inhere` then `file ./*` then use `cat ./<filename>` 


## Level 5 → Level 6
* **Goal:** Find a file hidden in the `inhere` directory that is human-readable, exactly 1033 bytes in size, and not executable.
* **Command:** `find . -type f -size 1033c ! -executable`
* **How it worked:** `find` traverses directories based on properties rather than names. `-type f` restricts the search to files, `-size 1033c` targets exactly 1033 bytes ('c' stands for characters), and `! -executable` uses boolean logic to filter out files that have execute permissions. This pinpointed the exact file needed.

## Level 6 → Level 7
* **Goal:** Find a file stored *somewhere* on the server that is owned by user `bandit7`, owned by group `bandit6`, and exactly 33 bytes in size.
* **Command:** `find / -user bandit7 -group bandit6 -size 33c 2>/dev/null`
* **How it worked:** Searching from the root directory `/` hits thousands of files you lack permission to read, cluttering the screen with errors. Adding `2>/dev/null` takes the "standard error" output stream (stream 2) and routes it to the system's black hole (`/dev/null`), leaving only the successful file path cleanly on the screen.