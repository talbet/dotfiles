# Print color palette.
function palette() {
    line="\u2588\u2588\u2588\u2588\u2588\u2588\u2588"
    echo ""
    function color() {
        for i in {000..255}; do
            printf "\x1b[38;5;10m$i "
            printf "\x1b[38;5;${i}m$line\n"
        done
    }
    function columns() {
        awk '{if(NR%8){printf "%s ",$0 }else {printf "%s\n",$0}} '
    }
    color | columns
}