# pick a random number
_RAND=`gshuf -i1-6 -n1`

# display a random ascii banner
case $_RAND in
1)
cat << X0

(╯°□°)╯︵ ┻━┻
X0
;;
2)
cat << X0

༼ つ ◕_◕ ༽つ
X0
;;
3)
cat << X0

♪┏(・o･)┛♪┗ ( ･o･) ┓♪
X0
;;
4)
cat << X0

ʕ •ᴥ•ʔ
X0
;;
5)
cat << X0

ಠ_ಠ
X0
;;
6)
cat << X0

ᶘ ᵒᴥᵒᶅ
X0
;;
esac
