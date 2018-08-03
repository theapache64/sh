ALIAS="alias code-insiders-update='wget -O - https://raw.githubusercontent.com/theapache64/sh/master/vscode_insiders_updater.sh -q --show-progress | bash'"
USER=$(whoami)
ALIAS_FILE="/home/$USER/.bash_aliases"
if grep -q "alias code-insiders-update='wget " $ALIAS_FILE; then
  echo "✅ Updater already exist"
else
  echo "Installing updater..."
  echo $ALIAS >> $ALIAS_FILE
  echo "✅ VSCode Insiders Updater Installed"
  echo "ℹ️ To update, execute 'code-insiders-update'"
fi

