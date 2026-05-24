# Bandit CTF Writeups: Levels 7 to 12

OverTheWire Bandit wargame solutions — objectives, commands, and notes.

**Host:** `bandit.labs.overthewire.org` | **Port:** `2220`

---

## Level 7 → 8

The password is in `data.txt`, next to the word `millionth`.

```bash
grep "millionth" data.txt
```

---

## Level 8 → 9

The password is the only line in `data.txt` that appears exactly once.

```bash
sort data.txt | uniq -u
```

`sort` groups identical lines together so `uniq -u` can isolate the one that doesn't repeat.

---

## Level 9 → 10

The password is in `data.txt` among the human-readable strings, preceded by several `=` characters.

```bash
strings data.txt | grep "==="
```

---

## Level 10 → 11

`data.txt` contains base64-encoded data.

```bash
base64 -d data.txt
```

---

## Level 11 → 12

All letters in `data.txt` have been rotated 13 positions (ROT13).

```bash
cat data.txt | tr 'a-zA-Z' 'n-za-mN-ZA-M'
```

---

## Level 12 → 13

`data.txt` is a hexdump of a file that has been repeatedly compressed. Work in a temp directory since you need write access.

```bash
mktemp -d
cd /tmp/tmp.XXXXXX
cp ~/data.txt .
xxd -r data.txt > data.bin
```

Use `file` at each step to identify the compression type, then extract accordingly.

```bash
# gzip
mv data.bin data.gz && gzip -d data.gz

# bzip2
mv data data.bz2 && bzip2 -d data.bz2

# gzip again
mv data data.gz && gzip -d data.gz

# tar
mv data data.tar && tar -xf data.tar        # → data5.bin

# tar
tar -xf data5.bin                           # → data6.bin

# bzip2
bzip2 -dc data6.bin > data6

# tar
tar -xf data6                               # → data8.bin

# gzip (final layer)
zcat data8.bin > data9.bin

cat data9.bin
```

Repeat the `file` → rename → extract cycle until `file` returns `ASCII text`.