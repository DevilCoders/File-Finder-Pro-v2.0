# File Finder Pro

**A comprehensive, feature-rich file search and analysis tool for developers and system administrators.**

[![Version](https://img.shields.io/badge/version-2.0-blue.svg)](https://github.com/DevilCoders/File-Finder-Pro-v2.0) [![Bash](https://img.shields.io/badge/bash-4.0%2B-orange.svg)](https://www.gnu.org/software/bash/) [![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20Unix-lightgrey.svg)](https://en.wikipedia.org/wiki/Unix-like)

---

## 📋 Table of Contents

- [Roadmap](ROADMAP.md)

---

## ✨ Features

### 🎯 **Core Functionality**

- **Multi-Extension Search** - Search for multiple file types simultaneously (e.g., `cpp,h,py`).
- **Advanced Filtering** - Filter by size, date, depth, and name patterns.
- **Real-time Progress** - Animated progress bars with spinning indicators.
- **Detailed Analysis** - File statistics, size analysis, and timeline information (planned for v2.1).
- **Interactive Menu** - User-friendly menu system with multiple operation modes.

### 🔧 **Advanced Tools**

- **Batch Operations** - Copy, move, archive, and generate reports for found files (planned for v2.1).
- **Directory Tree Visualization** - Visual representation of directory structures using `tree` or `find`.
- **Configuration Management** - Save and load user preferences (planned for v2.1).
- **Search Statistics** - Track usage patterns and search history (planned for v2.1).
- **Logging System** - Comprehensive activity logging to `~/.local/share/filefinderpro/logs/`.

### 🎨 **User Experience**

- **Rich Visual Interface** - Color-coded results with professional ASCII art.
- **System Information Display** - Real-time system stats (CPU, memory, disk) (planned for v2.1).
- **Error Handling** - Robust error checking with helpful messages.
- **Cross-platform Support** - Works on Linux, macOS, and Unix-like systems (Windows via WSL).

---

## 🚀 Installation

# Debian/Ubuntu Installation (Recommended)

### Quick Install (Script)

```bash
# Download the script
wget https://raw.githubusercontent.com/DevilCoders/File-Finder-Pro-v2.0/master/file-finder-pro.sh

# Make it executable
chmod +x file-finder-pro.sh

# Run it
./file-finder-pro.sh
```

### System-wide Installation

```bash
# Install to /usr/local/bin
sudo cp file-finder-pro.sh /usr/local/bin/ffp
sudo chmod +x /usr/local/bin/ffp

# Run from anywhere
ffp
```

### Clone Repository

```bash
git clone https://github.com/DevilCoders/File-Finder-Pro-v2.0.git
cd file-finder-pro
chmod +x file-finder-pro.sh
./file-finder-pro.sh
```

---

## ⚡ Quick Start

1. **Run the tool**:
    
    ```bash
    ffp
    ```
    
2. **Select operation mode**:
    
    ```bash
    📋 SELECT OPERATION MODE:
      1) 🔍 Basic Search
      2) 🔬 Advanced Search with Filters
      3) 📊 File Analysis Mode
      4) 🎯 Interactive Search
      5) 📁 Directory Tree View
      6) 🔧 Configuration Manager
      7) 📈 Search Statistics
      8) 🚀 Batch Operations
      9) ❓ Help & Documentation
      0) 🚪 Exit
    ```
    
3. **For basic search**:
    
    - Enter file extensions: `cpp,h,py,js and etc`
    - Specify output directory or use default
    - View results with detailed analysis

---

## 🎛️ Usage Modes

### 1. 🔍 **Basic Search**

Simple file extension-based search with enhanced results display.

```
>> Enter file extensions (comma-separated): cpp,h,py
>> Enter output directory (default: ./search_results_20250629_143022):
```

### 2. 🔬 **Advanced Search** (Planned for v2.1)

Comprehensive search with multiple filtering options.

```
>> File extensions (comma-separated): cpp,h
>> Minimum file size (KB, default: 0): 10
>> Maximum file size (MB, default: unlimited): 5
>> Modified within days (default: unlimited): 30
>> Exclude directories (comma-separated): build,dist
>> Search depth (default: unlimited): 5
>> Name pattern (regex, optional): test.*
```

### 3. 📊 **File Analysis Mode** (Planned for v2.1)

In-depth analysis of found files with statistics and insights.

### 4. 🎯 **Interactive Search** (Planned for v2.1)

Step-by-step guided search with real-time feedback.

### 5. 🌳 **Directory Tree View**

Visual representation of directory structure.

```
>> Directory to visualize (default: current): ./src
>> Maximum depth (default: 3): 4
```

### 6. 🔧 **Configuration Manager**

Manage user preferences and default settings.

### 7. 📈 **Search Statistics**

View usage history and search patterns.

### 8. 🚀 **Batch Operations**

Perform bulk operations on found files:

- Copy/move files
- Create archives
- Generate reports (NEED to FIX)
- Calculate disk usage (NEED to FIX)

### 9. ❓ **Help & Documentation**

Comprehensive help system with examples and usage patterns.

---

## 🔧 Advanced Features

### **Filtering Options**

|Filter Type|Description|Example|
|---|---|---|
|**Size**|Filter by file size|`+100k` (min 100KB), `-50M` (max 50MB)|
|**Date**|Filter by modification date|`-7` (within 7 days), `+30` (older than 30 days)|
|**Depth**|Limit search depth|`3` (maximum 3 subdirectories)|
|**Pattern**|Regex name matching|`test.*\.cpp$` (test files ending in .cpp)|
|**Exclude**|Skip directories|`build,dist,node_modules,__pycache__`|

### **File Analysis Features** (Planned for v2.1)

- **Size Statistics**: Total size, average size, largest/smallest files.
- **Timeline Analysis**: Oldest and newest files with modification dates.
- **Distribution Charts**: File count and size distribution by extension.
- **Duplicate Detection**: Identify potential duplicate files.
- **Path Analysis**: Most common directories and file locations.

### **Output Formats**

- **Text Files**: Simple file lists for each extension.
- **CSV Reports**: Structured data for spreadsheet import (planned for v2.1).
- **JSON Output**: Machine-readable format for automation (planned for v2.1).
- **HTML Reports**: Rich formatted reports with charts (planned for v2.1).

---

## ⚙️ Configuration

### Configuration File Location

- **Linux/macOS**: `~/.filefinderpro_config`
- **Custom**: Set `FILEFINDER_CONFIG` environment variable

### Sample Configuration

```bash
# File Finder Pro Configuration
DEFAULT_EXTENSIONS="cpp,h,py,js,java"
DEFAULT_OUTPUT_DIR="./search_results"
ENABLE_COLORS=true
SHOW_SYSTEM_INFO=true
MAX_DEPTH=10
EXCLUDE_DIRS="build,dist,node_modules,__pycache__,.git"
```

### Environment Variables

```bash
export FILEFINDER_CONFIG="/path/to/custom/config"
export FILEFINDER_LOG="/path/to/custom/log"
export FILEFINDER_NO_COLOR=1  # Disable colors
```

---

## 📚 Examples

### **Basic Usage**

```bash
# Search for C++ and header files
ffp
# Select option 1, enter: cpp,h

# Advanced search for large Python files
ffp
# Select option 2
# Extensions: py
# Min size: 100
# Modified within: 7
```

### **Command Line Integration**

```bash
# Quick search
ffp -e "js,ts" -o frontend_files

# Pipe results to other tools
ffp -e "txt" | wc -l

# Use with git
git ls-files | grep -E '\.(cpp|h)$' | ffp -e "cpp,h"
```

### **Common Use Cases**

#### **1. Code Review Preparation**

```bash
# Find source files modified in last week
ffp -e "cpp,h,py,java,js" -d 7 -x "build,dist,vendor"
```

#### **2. Cleanup Large Files**

```bash
# Find large files for cleanup
ffp -e "*" -s "+100M" -o large_files_report
```

#### **3. Project Analysis**

```bash
# Analyze project structure
ffp -e "cpp,h,py,js,java,rb,go" --analyze
```

---

## 📸 Screenshots

### Main Menu

```
 ███████╗██╗██╗     ███████╗    ███████╗██╗███╗   ██╗██████╗ ███████╗██████╗
 ██╔════╝██║██║     ██╔════╝    ██╔════╝██║████╗  ██║██╔══██╗██╔════╝██╔══██╗
 █████╗  ██║██║     █████╗      █████╗  ██║██╔██╗ ██║██║  ██║█████╗  ██████╔╝
 ██╔══╝  ██║██║     ██╔══╝      ██╔══╝  ██║██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗
 ██║     ██║███████╗███████╗    ██║     ██║██║ ╚████║██████╔╝███████╗██║  ██║
 ╚═╝     ╚═╝╚══════╝╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝
                    Professional Edition v2.0

📋 SELECT OPERATION MODE:
  1) 🔍 Basic Search (NEED to FIX)
  2) 🔬 Advanced Search with Filters
  3) 📊 File Analysis Mode - COMING in v2.1
  4) 🎯 Interactive Search - COMING in v2.1
  5) 📁 Directory Tree View
  6) 🔧 Configuration Manager
  7) 📈 Search Statistics (NEED to FIX)
  8) 🚀 Batch Operations
  9) ❓ Help & Documentation
  0) 🚪 Exit

```

### Search Results

```
✅ SEARCH RESULTS:
  Total files found: 247
  Output location: ./search_results_20250629_143022

  📄 CPP FILES: 89 found
     💾 Saved to: cpp_files.txt
     📋 Sample files:
        • src/main.cpp (2.3KB)
        • lib/utils.cpp (5.7KB)
        • tests/test_core.cpp (1.2KB)
        ... and 86 more files
    📊 Analysis:
       Total Size: 1.2MB
       Average Size: 13.8KB
       Largest: src/parser.cpp (89.2KB)
       Oldest: legacy/old_code.cpp (2023-01-15)
       Newest: src/feature.cpp (2025-06-28)
```

---

## 📋 Requirements

### **System Requirements**

- **Operating System**: Linux, macOS, or Unix-like system (Windows via WSL)
- **Shell**: Bash 4.0 or higher
- **Disk Space**: Minimal (< 1MB for script + logs)
- **Memory**: < 10MB during execution

### **Required Commands**

- `find` - File searching
- `stat` - File information
- `date` - Date formatting
- `tput` - Terminal capabilities

### **Optional Dependencies**

- `tree` - Enhanced directory tree visualization
- `git` - Git integration features
- `jq` - JSON output formatting
- `curl` - Update checking and remote features

### **Compatibility Matrix**

|Platform|Status|Notes|
|---|---|---|
|**Linux**|✅ Fully Supported|All distributions|
|**macOS**|✅ Fully Supported|macOS 10.12+|
|**FreeBSD**|✅ Supported|May need GNU coreutils|
|**OpenBSD**|⚠️ Limited|Some features may not work|
|**Windows (WSL)**|✅ Supported|Use WSL2 with Ubuntu|

---

## 🔄 Updates & Changelog

### **Version 2.0** (Current)

- ✨ Complete rewrite with modular architecture
- 🎨 Enhanced visual interface with animations
- 🔧 Advanced filtering and search capabilities
- 📊 File analysis features (planned for v2.1)
- ⚙️ Configuration management
- 📈 Usage statistics and logging
- 🚀 Batch operations support

### **Version 1.0** (Legacy)

- 🔍 Basic file extension search
- 📁 Simple output directory creation
- 📊 Basic file counting
- 🎨 Simple progress bar

---

## 🛠️ Troubleshooting

### **Common Issues**

#### **Permission Denied**

```bash
chmod +x file-finder-pro.sh
ls -la file-finder-pro.sh
```

#### **Command Not Found**

```bash
which find stat date tput
sudo apt-get install findutils coreutils  # Ubuntu/Debian
```

#### **Slow Performance**

```bash
# Use: smaller search depth, specific extensions, exclude directories
ffp -e "cpp,h" --depth 3 -x "build,dist"
```

#### **Memory Issues**

```bash
# Use: smaller directories, specific extensions, exclusions
ffp -e "py" -x "node_modules,__pycache__"
```

---

### **Development Setup**

```bash
git clone https://github.com/DevilCoders/File-Finder-Pro-v2.0.git
cd file-finder-pro
git checkout -b feature/new-feature
chmod +x file-finder-pro.sh
./file-finder-pro.sh
git commit -m "Add new feature"
git push origin feature/new-feature
```

### **Coding Standards**

- 4-space indentation
- Bash best practices
- Clear comments for complex logic
- Multi-platform testing
- Update documentation

---

## 📞 Support

- 📖 **Documentation**: This README.
- 🐛 **Issues**: [GitHub Issues](https://github.com/DevilCoders/File-Finder-Pro-v2.0/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/DevilCoders/File-Finder-Pro-v2.0/discussions)
- 📧 **Email**: [it24.daniel@gmail.com](mailto:it24.daniel@gmail.com)

### **Useful Resources**

- [Bash Manual](https://www.gnu.org/software/bash/manual/)
- [Find Command Guide](https://man7.org/linux/man-pages/man1/find.1.html)
- [Regular Expressions](https://www.regular-expressions.info/)
- [Unix File Permissions](https://en.wikipedia.org/wiki/File_system_permissions)

---

## 🔮 Roadmap

See [ROADMAP.md](https://github.com/DevilCoders/File-Finder-Pro-v2.0/blob/main/ROADMAP.md) for detailed plans.

### **Upcoming Features** (v2.1)

- 🌐 Web Interface - Browser-based GUI
- 🔌 Plugin System - Extensible architecture
- 📱 Mobile Support - Responsive design
- 🔄 Auto-update - Automatic version checking
- 🗄️ Database Integration - SQLite for large datasets
- 📊 File Analysis Mode
- 🎯 Interactive Search

### **Future Plans** (v3.0)

- 🤖 AI Integration - Smart file categorization
- ☁️ Cloud Support - Search cloud storage
- 🔒 Encryption - Built-in encryption support
- 📊 Advanced Analytics - Machine learning insights

---

**⭐ Star this repository if you find it helpful!**

**🔗 Share with your team and colleagues!**

---

_Made with ❤️ by the File Finder Pro team_
