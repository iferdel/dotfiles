alias nvimf='NVIM_APPNAME=nvim.iferdel.git nvim'

# Docker ps in card/expanded view (like psql \x auto)
alias dpscard='docker ps --format json --no-trunc | jq -r "\"╔═══════════════════════════════════════════════════════════════════════════════\n\" + \"║ \u001b[1;36mContainer:\u001b[0m \u001b[1;33m\(.Names)\u001b[0m\n\" + \"╠═══════════════════════════════════════════════════════════════════════════════\n\" + \"║ \u001b[1;34mID:\u001b[0m      \(.ID)\n\" + \"║ \u001b[1;34mImage:\u001b[0m   \(.Image)\n\" + \"║ \u001b[1;34mStatus:\u001b[0m  \u001b[1;32m\(.Status)\u001b[0m\n\" + \"║ \u001b[1;34mPorts:\u001b[0m   \(if .Ports == \"\" then \"(none)\" else .Ports end)\n\" + \"║ \u001b[1;34mCommand:\u001b[0m \(.Command)\n\" + \"╚═══════════════════════════════════════════════════════════════════════════════\n\""'

# Show custom aliases
# Usage: aliases         - compact view
#        aliases -v      - verbose view
aliases() {
    local verbose=false

    # Check for verbose flag
    if [[ "$1" == "-v" ]] || [[ "$1" == "--verbose" ]]; then
        verbose=true
    fi

    if $verbose; then
        # VERBOSE MODE
        echo "========================================="
        echo "  Custom Aliases and Functions"
        echo "========================================="
        echo ""

        # Show aliases
        if grep -q "^alias " ~/.bash_aliases 2>/dev/null; then
            echo "ALIASES:"
            echo "--------"
            grep "^alias " ~/.bash_aliases | while IFS= read -r line; do
                # Extract alias name and command
                alias_name=$(echo "$line" | sed "s/alias \([^=]*\)=.*/\1/")
                alias_cmd=$(echo "$line" | sed "s/alias [^=]*='\(.*\)'/\1/" | sed "s/alias [^=]*=\"\(.*\)\"/\1/")
                echo "  • $alias_name"
                # Format long commands with line wrapping
                if [ ${#alias_cmd} -gt 80 ]; then
                    echo "    → $(echo "$alias_cmd" | fold -s -w 76 | sed '2,$s/^/       /')"
                else
                    echo "    → $alias_cmd"
                fi
                echo ""
            done
        fi

        # Show functions
        if grep -q "^[a-zA-Z_][a-zA-Z0-9_]*() {" ~/.bash_aliases 2>/dev/null; then
            echo "FUNCTIONS:"
            echo "----------"
            grep "^[a-zA-Z_][a-zA-Z0-9_]*() {" ~/.bash_aliases | while IFS= read -r line; do
                func_name=$(echo "$line" | sed "s/\([^(]*\)().*/\1/")
                if [ "$func_name" != "aliases" ]; then
                    echo "  • $func_name()"
                    # Try to find a comment above the function
                    func_line=$(grep -n "^${func_name}() {" ~/.bash_aliases | cut -d: -f1)
                    if [ -n "$func_line" ]; then
                        comment=$(sed -n "$((func_line-1))p" ~/.bash_aliases | grep "^#" | sed "s/^# *//")
                        if [ -n "$comment" ]; then
                            echo "    → $comment"
                        fi
                    fi
                    echo ""
                fi
            done
        fi

        echo "========================================="
        echo "Total: $(grep -c "^alias " ~/.bash_aliases 2>/dev/null || echo 0) aliases, $(grep -c "^[a-zA-Z_][a-zA-Z0-9_]*() {" ~/.bash_aliases 2>/dev/null || echo 0) functions"
        echo "========================================="
    else
        # COMPACT MODE - show only names
        echo "Custom Aliases:"
        grep "^alias " ~/.bash_aliases 2>/dev/null | sed "s/alias \([^=]*\)=.*/  \1/" || echo "  (none)"
        echo ""
        echo "Custom Functions:"
        grep "^[a-zA-Z_][a-zA-Z0-9_]*() {" ~/.bash_aliases 2>/dev/null | \
            sed "s/() {/()/" | \
            grep -v "aliases()" | \
            sed "s/^/  /" || echo "  (none)"
        echo ""
        echo "Tip: Use 'aliases -v' for detailed view"
    fi
}
