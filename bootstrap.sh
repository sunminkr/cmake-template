#!/bin/bash
echo "Installing requirements. Details on README.md"

ListInstall() {
    if which vim </dev/null; 
    then echo "vim already installed"
	    echo "want to update? (Y/n)"
	    read reply
	    if [ $reply = "Y" ]; then apt -y install vim
	    elif [ $reply = "n" ]; then echo ""
	    else echo "unauthorized command:abort"
	    fi	    

    else apt -y install vim
    fi

    if which git >/dev/null; then echo "Git found"
    else echo "Git not found"	
    	echo "want to install? (Y/n)"
	    read reply
	    case ${reply} in 
		    y*|Y*) apt -y install git;;
		    n*|N*) echo "Continue without git";;
		    * ) echo "command error: abort";;
	    esac
    fi

    if which cmake >/dev/null; then echo "CMake already installed"
    else apt -y install cmake
    fi

    if which git >/dev/null; then echo "git already installed"
    else apt -y install git
    fi

    echo "Complete"
}

ListInstall

