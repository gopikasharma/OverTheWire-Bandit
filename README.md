# 🏴 OverTheWire: Bandit — Complete Walkthrough

<div align="center">

![Bandit](https://img.shields.io/badge/OverTheWire-Bandit-darkgreen?style=for-the-badge&logo=linux&logoColor=white)
![Progress](https://img.shields.io/badge/Progress-Level%200--12-blue?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

*A structured, beginner-friendly walkthrough of the OverTheWire Bandit wargame.*

</div>

---

## 📖 About This Repository

[OverTheWire Bandit](https://overthewire.org/wargames/bandit/) is the most popular entry-point wargame for learning Linux command-line fundamentals and basic security concepts. Each level presents a challenge that requires you to find a password hidden somewhere on the system using Linux tools.

This repo documents my personal journey through Bandit — not just the commands, but **why they work**. It's structured to be useful both as a personal reference and as a learning resource for others.

---

## 🗂️ Repository Structure

```
overthewire-bandit/
├── README.md                   ← You are here (overview + quick reference)
├── levels/
├── scripts/
│   └──              ← Helper script to SSH into any level
└── assets/
    └──              ← Linux concepts reference sheet
```

---

## ⚡ Quick Connection Reference

| Variable | Value |
|---|---|
| **Host** | `bandit.labs.overthewire.org` |
| **Port** | `2220` |
| **Username pattern** | `banditN` (where N is the level number) |

```bash
# Generic connection template
ssh banditN@bandit.labs.overthewire.org -p 2220

# Level 0 (starting point)
ssh bandit0@bandit.labs.overthewire.org -p 2220
# Password: bandit0
```

---

## 🚀 Getting Started

1. Visit [overthewire.org/wargames/bandit](https://overthewire.org/wargames/bandit/) to read the official rules.
2. Connect to Level 0: `ssh bandit0@bandit.labs.overthewire.org -p 2220` (password: `bandit0`)
3. Follow along with the level files in the [`levels/`](levels/) directory.

> **⚠️ Spoiler Policy:** Each level file contains the full solution. Try the level yourself first before reading!

---

## 📚 Useful Resources

- [OverTheWire Bandit](https://overthewire.org/wargames/bandit/) — Official game
- [explainshell.com](https://explainshell.com) — Paste any command to see it explained
- [tldr.sh](https://tldr.sh) — Simplified man pages
- [Linux Command Line Cheatsheet](https://cheatography.com/davechild/cheat-sheets/linux-command-line/)
-https://status.overthewire.org/

---

<div align="center">
<sub>Built while learning. Documented to teach.</sub>
</div>