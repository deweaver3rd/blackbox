clear
echo "
:::::::::  :::            :::      ::::::::  :::    ::: :::::::::   ::::::::  :::    :::
:+:    :+: :+:          :+: :+:   :+:    :+: :+:   :+:  :+:    :+: :+:    :+: :+:    :+:
+:+    +:+ +:+         +:+   +:+  +:+        +:+  +:+   +:+    +:+ +:+    +:+  +:+  +:+
+#++:++#+  +#+        +#++:++#++: +#+        +#++:++    +#++:++#+  +#+    +:+   +#++:+
+#+    +#+ +#+        +#+     +#+ +#+        +#+  +#+   +#+    +#+ +#+    +#+  +#+  +#+
#+#    #+# #+#        #+#     #+# #+#    #+# #+#   #+#  #+#    #+# #+#    #+# #+#    #+#
#########  ########## ###     ###  ########  ###    ### #########   ########  ###    ###

::::::::::: ::::    :::  :::::::: ::::::::::: :::     :::        :::        :::::::::: :::::::::
    :+:     :+:+:   :+: :+:    :+:    :+:   :+: :+:   :+:        :+:        :+:        :+:    :+:
    +:+     :+:+:+  +:+ +:+           +:+  +:+   +:+  +:+        +:+        +:+        +:+    +:+
    +#+     +#+ +:+ +#+ +#++:++#++    +#+ +#++:++#++: +#+        +#+        +#++:++#   +#++:++#:
    +#+     +#+  +#+#+#        +#+    +#+ +#+     +#+ +#+        +#+        +#+        +#+    +#+
    #+#     #+#   #+#+# #+#    #+#    #+# #+#     #+# #+#        #+#        #+#        #+#    #+#
########### ###    ####  ########     ### ###     ### ########## ########## ########## ###    ###
";

if [ "$(uname)" = "Linux" ]; then
    INSTALL_DIR="$HOME/.blackbox"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"

    # Instal deps
    sudo apt-get install -y git python2.7 libncurses5-dev
else
  echo "[✘] Installation failed, this operating system is not supported! [✘]";
fi

echo "[✔] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[◉] A directory blackbox was found! Do you want to replace it? [Y/n]:" ;
    read mama
    if [ "$mama" = "y" ]; then
        sudo rm -rf "$INSTALL_DIR"
        sudo rm "$BIN_DIR"blackbox-*
    else
        echo "[✘] If you want to install you must remove previous installations [✘] ";
        echo "[✘] Installation failed! [✘] ";
        exit
    fi
fi

echo "[✔] Installing fsociety...";
echo "";
git clone --depth=1 https://github.com/Manisso/fsociety "$INSTALL_DIR/fsociety";
echo "#!$BASH_PATH
python $INSTALL_DIR/fsociety/fsociety.py" '${1+"$@"}' > "$INSTALL_DIR/blackbox-fsociety";
chmod +x "$INSTALL_DIR/blackbox-fsociety";
sudo cp "$INSTALL_DIR/blackbox-fsociety" "$BIN_DIR"
rm "$INSTALL_DIR/blackbox-fsociety";


echo "[✔] Installing One-Lin3r...";
echo "";
git clone --depth=1 https://github.com/D4Vinci/One-Lin3r.git "$INSTALL_DIR/One-Lin3r";
echo "#!$BASH_PATH
cd ~/.blackbox/One-Lin3r/
python $INSTALL_DIR/One-Lin3r/One_Lin3r.py" '${1+"$@"}' > "$INSTALL_DIR/blackbox-onelin3r";
chmod +x "$INSTALL_DIR/blackbox-onelin3r";
sudo cp "$INSTALL_DIR/blackbox-onelin3r" "$BIN_DIR"
rm "$INSTALL_DIR/blackbox-onelin3r";

if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[✔] Tools installed successfully! [✔]";
    echo "";
    echo "[✔]====================================================================[✔]";
    echo "[✔]      All is done!! You can execute tools by typing the name !       [✔]";
    echo "[✔]====================================================================[✔]";
    echo "";
else
    echo "[✘] Installation failed! [✘] ";
    exit
fi
