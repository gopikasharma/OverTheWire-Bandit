
 Bandit CTF Writeups: Levels 7 to 12

This document contains the objectives, terminal commands, and system-level logic for solving levels 7 through 12  of the OverTheWire Bandit wargame.

---

**Host:** `bandit.labs.overthewire.org`
**Port:** `2220`

---

## Level 7 → Level 8

 
* **Goal:** The password is stored in `data.txt` next to the word **"millionth"**.
* **Command:** `bandit7@bandit:~$ grep "millionth" data.txt`

## Level 8 → Level 9
* **Goal:** Find the password stored in the file `data.txt `and is the only line of text that occurs only once
* **Command:** `bandit8@bandit:~$ sort data.txt | uniq -u`


## Level 9 → Level 10
* **Goal:** Find the password stored in the file `data.txt` in one of the few human-readable strings, preceded by several ‘=’ characters.
* **Command:** `bandit9@bandit:~$ strings data.txt |grep "==="`

## Level 10 → Level 11
* **Goal:** Find the password stored in the file data.txt, which contains base64 encoded data
* **Command:** `bandit10@bandit:~$ base64 -d data.txt `


## Level 11 → Level 12
* **Goal:** Find the password stored in the file data.txt, where all lowercase (a-z) and uppercase (A-Z) letters have been rotated by 13 positions
* **Command:** `bandit11@bandit:~$ cat data.txt | tr 'a-zA-Z' 'n-za-mN-ZA-M' `


## Level 12 → Level 13
* **Goal:** Find the password stored in the file data.txt, which is a hexdump of a file that has been repeatedly compressed. 
## 💻 Solution
 
This level requires multiple steps. Work in a temporary directory since you need write access.
---

## Method 1: The Manual Approach

This method walks through the exact commands used to inspect and extract each layer one by one.

### 1. Setup the Workspace
Always create a temporary directory to work in so you don't clutter the system or run into permission issues.
```bash
mktemp -d
cd [PATH]
cp ~/data.txt .
```

### 2. Reverse the Hex Dump
The original file is a hexdump. Use `xxd` to revert it back into a compressed binary file.
```bash
xxd -r data.txt > data.bin
```

### 3. Peel the Layers
Use the `file` command at every step to determine the compression type, rename the file with the appropriate extension, and extract it.

**Layer 1: gzip**
```bash
file data.bin
mv data.bin data.gz
gzip -d data.gz
```

**Layer 2: bzip2**
```bash
file data
mv data data.bz2
bzip2 -d data.bz2
```

**Layer 3: gzip**
```bash
file data
mv data data.gz
gzip -d data.gz
```

**Layer 4: tar**
```bash
file data
mv data data.tar
tar -xf data.tar
# Outputs: data5.bin
```

**Layer 5: tar**
```bash
file data5.bin
tar -xf data5.bin
# Outputs: data6.bin
```

**Layer 6: bzip2**
```bash
file data6.bin
bzip2 -dc data6.bin > data6
```

**Layer 7: tar**
```bash
file data6
tar -xf data6
# Outputs: data8.bin
```

**Layer 8: gzip (Final)**
```bash
file data8.bin
zcat data8.bin > data9.bin
```

### 4. Read the Password
Finally, check the file type to confirm it's readable text, and print the output.
```bash
file data9.bin # Returns "ASCII text"
cat data9.bin
# The password is [REDACTED]
```

---

## Method 2: The Automated Script Approach

Instead of manually checking file types, you can use a Bash script to read the file signature, rename the file, and run the correct decompression tool automatically until it finds plain text.

> **Note:** The full source code for this script is located in this repository at [`scripts/extractor.sh`](scripts/extractor.sh).

### Running the Automation
To use the script, ensure you have reversed the hexdump first, grant the script execution permissions, and pass the binary file as an argument.

```bash
# 1. Convert the hex dump
xxd -r data.txt > firstfile.bin

# 2. Make the script executable
chmod +x scripts/extractor.sh

# 3. Run the script against the binary
./scripts/extractor.sh firstfile.bin
```

**Expected Output:**
```text
Extraction complete! The base file is: temp
Here are the contents:
The password is [REDACTED]
```
