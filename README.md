# 🚀 Dotfiles Arsenal - Seamless Development Environment

<div align="center">

### _"Your Development Environment, Weaponized for Productivity"_

</div>

<p align="center">

![Build](https://img.shields.io/badge/build-passing-brightgreen)
![Arch](https://img.shields.io/badge/arch-linux-blue)
![License](https://img.shields.io/badge/license-MIT-purple)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-orange)

</p>

---

## ✨ Features

| Category                 | Capabilities                                                    |
| ------------------------ | --------------------------------------------------------------- |
| **🎯 One-Command Setup** | Single script to bootstrap your entire development environment  |
| **🔄 Smart Symlinking**  | Automatic dotfile management with selective exclusions          |
| **📦 AUR Integration**   | Auto-installs `yay` and manages AUR packages seamlessly         |
| **⚡ Arch Optimized**    | Specifically tuned for Arch Linux performance                   |
| **🛡️ Idempotent**        | Safe to run multiple times - only installs missing dependencies |
| **🎨 VSCode Ready**      | Optional extension installer integration                        |

## 🎬 Quick Start

```bash
# Clone the arsenal
git clone https://github.com/yourusername/.dotfiles.git ~/00-projects/.dotfiles

# Enter the armory
cd ~/00-projects/.dotfiles

# Deploy (it's that simple)
./install.sh
```

## 📦 What Gets Installed

```
┌─────────────────────────────────────────────────────────┐
│ 📦 Dependencies                                         │
├─────────────────────────────────────────────────────────┤
│ • curl - Data transfer utility                          │
│ • stow - Symlink farm manager                           │
│ • git - Version control                                 │
│ • vscodium-bin - Open-source VS Code alternative        │
│ • zen-browser-bin - Higly customizable Webbrowser       │
│ • discord - Communication platform                      │
└─────────────────────────────────────────────────────────┘
```

## 🧠 Smart Exclusion System

Your scripts and documentation stay where they belong:

```yaml
Excluded Patterns:
✓ _.sh - Shell scripts (not linked)
✓ _.md - Markdown files (not linked)
   ✓ README* - Documentation (not linked)
```

## 🛠️ Customization

### Add Your Own Dependencies

Edit the `dependencies` array in `install.sh`:

```bash
dependencies=(curl stow git vscodium-bin zen-browser-bin discord your-package-here)
```

### Modify Exclusion Rules

Adjust the `stow` command in `link_file()` function:

```bash
stow --adopt --target "$HOME" \
     --ignore '\.sh$' \
     --ignore '\.md$' \
     --ignore '^your-pattern$' \
 .
```

## 📂 Project Structure

```
.dotfiles/
├── install.sh # Main installer script
├── install-vscode-extensions.sh # Main installer script
├── .config/ # App configs → ~/.config/
│ ├── VSCodium/
│ └── ...
└── README.md # NOT linked (excluded)
```

## 🔧 Requirements

| Requirement | Details                                              |
| ----------- | ---------------------------------------------------- |
| **OS**      | Arch Linux (or Arch-based like Manjaro, EndeavourOS) |
| **Network** | Internet connection for package downloads            |

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'Add some amazing'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a Pull Request

## 📝 License

MIT © Marc Müller

---

<div align="center">

### ⚡ From zero to productive in 60 seconds ⚡

**[Pull Requests](https://github.com/mmueller96/.dotfiles/pulls) · [Star on GitHub](https://github.com/mmueller96/.dotfiles)**

</div>
