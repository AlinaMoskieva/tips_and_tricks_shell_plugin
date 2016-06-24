selection=
until [ "$selection" = "0" ]; do
    echo ""
    echo "PROGRAM MENU"
    echo "1 - show tip"
    echo ""
    echo "2 - show kek"
    echo ""
    echo "0 - exit program"
    echo ""
    echo -n "Enter selection: "
    read selection
    echo ""
    case $selection in
        1 ) ruby -r "~/Desktop/parser.rb" -e "Parse.new.init";;
        2 ) ruby -r "~/Desktop/parser.rb" -e "Parse.new.kek";;
        0 ) exit ;;
        * ) echo "Please enter 1, 2, or 0"
    esac
done

