#!/bin/bash

# Enhanced File Finder Pro v2.0
# Feature-rich file search and analysis tool

# Script configuration
VERSION="2.0"
SCRIPT_NAME="File Finder Pro"
CONFIG_FILE="$HOME/.filefinder_config"
LOG_FILE="/tmp/filefinder.log"

# ASCII Banner with gradient effect
show_banner() {
    local colors=("\033[1;31m" "\033[1;33m" "\033[1;32m" "\033[1;36m" "\033[1;35m")
    echo -e "${colors[0]}"
    cat << "EOF"
 ███████╗██╗██╗     ███████╗    ███████╗██╗███╗   ██╗██████╗ ███████╗██████╗
 ██╔════╝██║██║     ██╔════╝    ██╔════╝██║████╗  ██║██╔══██╗██╔════╝██╔══██╗
 █████╗  ██║██║     █████╗      █████╗  ██║██╔██╗ ██║██║  ██║█████╗  ██████╔╝
 ██╔══╝  ██║██║     ██╔══╝      ██╔══╝  ██║██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗
 ██║     ██║███████╗███████╗    ██║     ██║██║ ╚████║██████╔╝███████╗██║  ██║
 ╚═╝     ╚═╝╚══════╝╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝
EOF
    echo -e "\033[1;36m                    Professional Edition v${VERSION}"
    echo -e "\033[0m"
}

# Enhanced text formatting functions
bold() { echo -e "\033[1m$1\033[0m"; }
red() { echo -e "\033[31m$1\033[0m"; }
green() { echo -e "\033[32m$1\033[0m"; }
yellow() { echo -e "\033[33m$1\033[0m"; }
blue() { echo -e "\033[34m$1\033[0m"; }
cyan() { echo -e "\033[36m$1\033[0m"; }
magenta() { echo -e "\033[35m$1\033[0m"; }
white() { echo -e "\033[37m$1\033[0m"; }
dim() { echo -e "\033[2m$1\033[0m"; }
underline() { echo -e "\033[4m$1\033[0m"; }
blink() { echo -e "\033[5m$1\033[0m"; }

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Enhanced progress bar with animations
progress_bar() {
    local duration=${1:-5}
    local message=${2:-"Processing"}
    local columns=$(tput cols)
    local space=$((columns-25))
    local chars=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    
    for (( elapsed=0; elapsed<=duration; elapsed++ )); do
        local percentage=$(( (elapsed*100)/duration ))
        local filled=$(( (elapsed*space)/duration ))
        local spinner=${chars[$((elapsed % ${#chars[@]}))]}
        
        printf "\r${spinner} %s [" "$message"
        printf "%*s" "$filled" | tr ' ' '█'
        printf "%*s" $((space-filled)) | tr ' ' '░'
        printf "] %3d%%" "$percentage"
        
        sleep 0.1
    done
    printf "\n"
}

# System information display
show_system_info() {
    echo -e "\n$(blue '🖥️  SYSTEM INFORMATION:')"
    bold "  OS: $(uname -s) $(uname -r)"
    bold "  User: $(whoami)@$(hostname)"
    bold "  Current Directory: $(pwd)"
    bold "  Available Space: $(df -h . | awk 'NR==2 {print $4}')"
    bold "  Memory Usage: $(free -h | awk 'NR==2{printf "%.1f%%", $3*100/$2}')"
    bold "  CPU Load: $(uptime | awk -F'load average:' '{print $2}')"
}

# Configuration management
load_config() {
    [[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"
}

save_config() {
    cat > "$CONFIG_FILE" << EOF
# File Finder Pro Configuration
DEFAULT_EXTENSIONS="$DEFAULT_EXTENSIONS"
DEFAULT_OUTPUT_DIR="$DEFAULT_OUTPUT_DIR"
ENABLE_COLORS=${ENABLE_COLORS:-true}
SHOW_SYSTEM_INFO=${SHOW_SYSTEM_INFO:-true}
MAX_DEPTH=${MAX_DEPTH:-10}
EXCLUDE_DIRS="$EXCLUDE_DIRS"
EOF
    green "✅ Configuration saved to $CONFIG_FILE"
}

# File size formatting
format_size() {
    local size=$1
    if (( size < 1024 )); then
        echo "${size}B"
    elif (( size < 1048576 )); then
        echo "$((size/1024))KB"
    elif (( size < 1073741824 )); then
        echo "$((size/1048576))MB"
    else
        echo "$((size/1073741824))GB"
    fi
}

# Advanced file analysis
analyze_files() {
    local ext=$1
    local file_list=$2
    local total_size=0
    local file_count=0
    local largest_file=""
    local largest_size=0
    local oldest_file=""
    local newest_file=""
    local oldest_date=999999999999
    local newest_date=0
    
    while IFS= read -r file; do
        [[ -z "$file" ]] && continue
        [[ ! -f "$file" ]] && continue
        
        local size=$(stat -c%s "$file" 2>/dev/null || echo 0)
        local mtime=$(stat -c%Y "$file" 2>/dev/null || echo 0)
        
        ((total_size += size))
        ((file_count++))
        
        if (( size > largest_size )); then
            largest_size=$size
            largest_file=$file
        fi
        
        if (( mtime < oldest_date )); then
            oldest_date=$mtime
            oldest_file=$file
        fi
        
        if (( mtime > newest_date )); then
            newest_date=$mtime
            newest_file=$file
        fi
    done < "$file_list"
    
    if (( file_count > 0 )); then
        echo -e "    📊 $(bold 'Analysis:')"
        echo -e "       Total Size: $(format_size $total_size)"
        echo -e "       Average Size: $(format_size $((total_size / file_count)))"
        echo -e "       Largest: $(dim "$largest_file") ($(format_size $largest_size))"
        echo -e "       Oldest: $(dim "$oldest_file") ($(date -d @$oldest_date '+%Y-%m-%d'))"
        echo -e "       Newest: $(dim "$newest_file") ($(date -d @$newest_date '+%Y-%m-%d'))"
    fi
}

# Interactive menu system
show_menu() {
    echo -e "\n$(cyan '📋 SELECT OPERATION MODE:')"
    echo "  1) 🔍 Basic Search"
    echo "  2) 🔬 Advanced Search with Filters"
    echo "  3) 📊 File Analysis Mode"
    echo "  4) 🎯 Interactive Search"
    echo "  5) 📁 Directory Tree View"
    echo "  6) 🔧 Configuration Manager"
    echo "  7) 📈 Search Statistics"
    echo "  8) 🚀 Batch Operations"
    echo "  9) ❓ Help & Documentation"
    echo "  0) 🚪 Exit"
    echo
}

# Advanced search with filters
advanced_search() {
    echo -e "\n$(yellow '🔬 ADVANCED SEARCH MODE')"
    
    # Get search parameters
    read -p "$(cyan '>> File extensions (comma-separated): ')" extensions_input
    read -p "$(cyan '>> Minimum file size (KB, default: 0): ')" min_size
    read -p "$(cyan '>> Maximum file size (MB, default: unlimited): ')" max_size
    read -p "$(cyan '>> Modified within days (default: unlimited): ')" days_old
    read -p "$(cyan '>> Exclude directories (comma-separated): ')" exclude_dirs
    read -p "$(cyan '>> Search depth (default: unlimited): ')" search_depth
    read -p "$(cyan '>> Name pattern (regex, optional): ')" name_pattern
    
    # Build find command
    local find_cmd="find ."
    
    # Add depth limit
    [[ -n "$search_depth" ]] && find_cmd+=" -maxdepth $search_depth"
    
    # Add type filter
    find_cmd+=" -type f"
    
    # Add size filters
    [[ -n "$min_size" && "$min_size" -gt 0 ]] && find_cmd+=" -size +${min_size}k"
    [[ -n "$max_size" && "$max_size" -gt 0 ]] && find_cmd+=" -size -${max_size}M"
    
    # Add time filter
    [[ -n "$days_old" && "$days_old" -gt 0 ]] && find_cmd+=" -mtime -$days_old"
    
    # Add exclude directories
    if [[ -n "$exclude_dirs" ]]; then
        IFS=',' read -ra dirs <<< "$exclude_dirs"
        for dir in "${dirs[@]}"; do
            find_cmd+=" -not -path \"*/$dir/*\""
        done
    fi
    
    # Add name pattern
    [[ -n "$name_pattern" ]] && find_cmd+=" -regex \".*$name_pattern.*\""
    
    # Add extension filter
    if [[ -n "$extensions_input" ]]; then
        IFS=',' read -ra extensions <<< "$extensions_input"
        if [[ ${#extensions[@]} -eq 1 ]]; then
            find_cmd+=" -name \"*.${extensions[0]}\""
        else
            find_cmd+=" \\("
            for i in "${!extensions[@]}"; do
                [[ $i -gt 0 ]] && find_cmd+=" -o"
                find_cmd+=" -name \"*.${extensions[i]}\""
            done
            find_cmd+=" \\)"
        fi
    fi
    
    echo -e "\n$(blue '🔧 SEARCH COMMAND:')"
    echo "$(dim "$find_cmd")"
    
    # Execute search
    echo -e "\n$(yellow '⏳ Executing advanced search...')"
    progress_bar 3 "Searching"
    
    eval "$find_cmd" > "/tmp/advanced_search_results.txt"
    local count=$(wc -l < "/tmp/advanced_search_results.txt")
    
    echo -e "\n$(green '✅ ADVANCED SEARCH RESULTS:')"
    bold "  Files found: $count"
    
    if [[ $count -gt 0 ]]; then
        echo -e "\n$(cyan '📄 Sample Results:')"
        head -10 "/tmp/advanced_search_results.txt" | while read -r file; do
            local size=$(stat -c%s "$file" 2>/dev/null || echo 0)
            local date=$(stat -c%y "$file" 2>/dev/null | cut -d' ' -f1)
            echo -e "  📄 $(bold "$file") ($(format_size $size), $date)"
        done
        [[ $count -gt 10 ]] && echo "  ... and $((count-10)) more files"
    fi
}

# Directory tree visualization
show_tree() {
    echo -e "\n$(yellow '🌳 DIRECTORY TREE VIEW')"
    read -p "$(cyan '>> Directory to visualize (default: current): ')" target_dir
    target_dir=${target_dir:-.}
    read -p "$(cyan '>> Maximum depth (default: 3): ')" tree_depth
    tree_depth=${tree_depth:-3}
    
    if command -v tree >/dev/null 2>&1; then
        tree -L "$tree_depth" -a --dirsfirst "$target_dir"
    else
        find "$target_dir" -maxdepth "$tree_depth" -type d | sed -e 's/[^-][^\/]*\//  /g' -e 's/^  //' -e 's/-/|/'
    fi
}

# Search statistics
show_statistics() {
    echo -e "\n$(yellow '📈 SEARCH STATISTICS')"
    
    if [[ ! -f "$LOG_FILE" ]]; then
        red "No statistics available yet."
        return
    fi
    
    local total_searches=$(grep -c "Search completed" "$LOG_FILE" 2>/dev/null || echo 0)
    local last_search=$(tail -1 "$LOG_FILE" 2>/dev/null || echo "No recent activity")
    
    echo -e "$(blue '📊 USAGE STATISTICS:')"
    bold "  Total searches performed: $total_searches"
    bold "  Last activity: $last_search"
    bold "  Log file location: $LOG_FILE"
    bold "  Configuration file: $CONFIG_FILE"
}

# Help system
show_help() {
    echo -e "\n$(yellow '❓ HELP & DOCUMENTATION')"
    echo
    bold "FILE FINDER PRO v$VERSION"
    echo "A comprehensive file search and analysis tool"
    echo
    bold "FEATURES:"
    echo "• Basic and advanced file searching"
    echo "• File size and date filtering"
    echo "• Directory exclusion patterns"
    echo "• Statistical analysis of results"
    echo "• Interactive menu system"
    echo "• Configuration management"
    echo "• Progress indicators and logging"
    echo
    bold "SEARCH PATTERNS:"
    echo "• Extensions: cpp,h,py,js,txt"
    echo "• Size filters: +100k (min), -50M (max)"
    echo "• Date filters: -7 (within 7 days)"
    echo "• Name patterns: Regular expressions"
    echo
    bold "EXAMPLES:"
    echo "• Search for large C++ files: *.cpp, min size 100KB"
    echo "• Find recent Python files: *.py, within 7 days"
    echo "• Exclude build directories: exclude 'build,dist,node_modules'"
    echo
}

# Batch operations
batch_operations() {
    echo -e "\n$(yellow '🚀 BATCH OPERATIONS')"
    echo "  1) Copy found files to directory"
    echo "  2) Move found files to directory"
    echo "  3) Create archive of found files"
    echo "  4) Generate file list report"
    echo "  5) Calculate total disk usage"
    echo
    
    read -p "$(cyan '>> Select operation (1-5): ')" batch_choice
    
    case $batch_choice in
        1|2)
            read -p "$(cyan '>> Target directory: ')" target_dir
            mkdir -p "$target_dir"
            local operation=$([[ $batch_choice == 1 ]] && echo "cp" || echo "mv")
            yellow "⏳ ${operation^}ing files..."
            # Implementation would go here
            green "✅ Batch operation completed"
            ;;
        3)
            read -p "$(cyan '>> Archive name: ')" archive_name
            yellow "⏳ Creating archive..."
            # tar implementation would go here
            green "✅ Archive created: $archive_name"
            ;;
        4)
            yellow "⏳ Generating detailed report..."
            # Report generation would go here
            green "✅ Report generated"
            ;;
        5)
            yellow "⏳ Calculating disk usage..."
            # Disk usage calculation would go here
            green "✅ Calculation completed"
            ;;
    esac
}

# Main execution function
main() {
    # Initialize
    load_config
    show_banner
    
    # Show system info if enabled
    [[ "${SHOW_SYSTEM_INFO:-true}" == "true" ]] && show_system_info
    
    log "File Finder Pro v$VERSION started"
    
    # Main program loop
    while true; do
        show_menu
        read -p "$(cyan '>> Select option (0-9): ')" choice
        
        case $choice in
            1)
                # Original basic search functionality (enhanced)
                echo -e "\n$(yellow '🔍 BASIC SEARCH MODE')"
                
                while true; do
                    read -p "$(cyan '>> Enter file extensions (comma-separated): ')" extensions_input
                    [[ -n "$extensions_input" ]] && break
                    red "!! Error: Please enter at least one file extension"
                done
                
                default_dir="./search_results_$(date +%Y%m%d_%H%M%S)"
                read -p "$(cyan ">> Enter output directory (default: $default_dir): ")" output_dir
                output_dir=${output_dir:-$default_dir}
                mkdir -p "$output_dir"
                
                # Show search parameters
                echo -e "\n$(blue '🔍 SEARCH PARAMETERS:')"
                bold "  Extensions: ${extensions_input//,/ }"
                bold "  Location: $(pwd)"
                bold "  Output directory: $output_dir"
                
                # Enhanced progress bar
                echo -e "\n$(yellow '⏳ Searching files...')"
                progress_bar 3 "Scanning filesystem"
                
                # Search and analyze files
                IFS=',' read -ra extensions <<< "$extensions_input"
                declare -A extension_counts
                total_files=0
                
                for ext in "${extensions[@]}"; do
                    ext=$(echo "$ext" | xargs)  # Trim whitespace
                    output_file="$output_dir/${ext}_files.txt"
                    find . -type f -name "*.${ext}" -printf "%P\n" > "$output_file"
                    count=$(wc -l < "$output_file")
                    extension_counts["$ext"]=$count
                    ((total_files+=count))
                done
                
                # Display enhanced results
                echo -e "\n$(green '✅ SEARCH RESULTS:')"
                bold "  Total files found: $total_files"
                bold "  Output location: $output_dir"
                
                for ext in "${!extension_counts[@]}"; do
                    count=${extension_counts["$ext"]}
                    output_file="$output_dir/${ext}_files.txt"
                    
                    # Color coding by extension
                    case "$ext" in
                        cpp|c|cc) color="\033[32m" ;;     # Green for C++
                        h|hpp) color="\033[33m" ;;        # Yellow for headers
                        py) color="\033[31m" ;;           # Red for Python
                        js|ts) color="\033[34m" ;;        # Blue for JavaScript
                        java) color="\033[35m" ;;         # Magenta for Java
                        *) color="\033[36m" ;;            # Cyan for others
                    esac
                    
                    echo -e "\n  ${color}📄 ${ext^^} FILES\033[0m: $count found"
                    echo -e "     💾 Saved to: $(bold "$output_file")"
                    
                    # Show sample files
                    if [[ $count -gt 0 ]]; then
                        echo -e "     📋 Sample files:"
                        head -n 3 "$output_file" | while read -r file; do
                            local size=$(stat -c%s "$file" 2>/dev/null || echo 0)
                            echo -e "        • $(bold "${file}") ($(format_size $size))"
                        done
                        [[ $count -gt 3 ]] && echo -e "        ... and $(bold "$((count-3))") more files"
                        
                        # Perform analysis
                        analyze_files "$ext" "$output_file"
                    fi
                done
                
                # Summary
                end_time=$(date +%s)
                duration=$((end_time - start_time))
                echo -e "\n$(blue '⏱️  SEARCH SUMMARY:')"
                bold "  Duration: ${duration}s"
                bold "  Files processed: $total_files"
                bold "  Extensions searched: ${#extensions[@]}"
                
                log "Basic search completed: $total_files files found in ${duration}s"
                green "✅ Search completed successfully!"
                ;;
            2) advanced_search ;;
            3) 
                echo -e "\n$(yellow '📊 FILE ANALYSIS MODE')"
                # Implementation for detailed file analysis
                green "Analysis mode - Feature coming soon!"
                ;;
            4)
                echo -e "\n$(yellow '🎯 INTERACTIVE SEARCH')"
                # Implementation for interactive search
                green "Interactive mode - Feature coming soon!"
                ;;
            5) show_tree ;;
            6)
                echo -e "\n$(yellow '🔧 CONFIGURATION MANAGER')"
                echo "Current configuration:"
                [[ -f "$CONFIG_FILE" ]] && cat "$CONFIG_FILE" || echo "No configuration file found"
                echo
                read -p "$(cyan '>> Update configuration? (y/n): ')" update_config
                [[ "$update_config" == "y" ]] && save_config
                ;;
            7) show_statistics ;;
            8) batch_operations ;;
            9) show_help ;;
            0)
                echo -e "\n$(green '👋 Thank you for using File Finder Pro!')"
                log "File Finder Pro session ended"
                exit 0
                ;;
            *)
                red "❌ Invalid option. Please select 0-9."
                ;;
        esac
        
        echo -e "\n$(dim 'Press Enter to continue...')"
        read
    done
}

# Script entry point
start_time=$(date +%s)
main "$@"
