# Getting current version 
CURRENT_VERSION_NAME=$(code-insiders --version | sed -n 1p) &&
CURRENT_VERSION=$(code-insiders --version | sed -n 2p) &&

echo "🔀 Current version is $CURRENT_VERSION_NAME ($CURRENT_VERSION)" &&
echo "🔄 Fetching latest version details ..." &&

if ! [ -x "$(command -v jq)" ]; then
  echo "Installing jq..."
  sudo apt install jq
fi

API_RESP=$(curl -s "https://vscode-update.azurewebsites.net/api/update/linux-deb-x64/insider/latest") &&

LATEST_VERSION=$(echo $API_RESP | jq -r '.version') &&
LATEST_VERSION_NAME=$(echo $API_RESP | jq -r '.productVersion') &&

echo "🌟 Latest version is $LATEST_VERSION_NAME ($LATEST_VERSION)" &&

if [ "$LATEST_VERSION" = "$CURRENT_VERSION" ];
then
  echo "✅ You're running on latest version"
else
  # Download latest version
  DOWNLOAD_LINK=$(echo $API_RESP | jq -r '.url') 
  echo "📩 Downloading latest version ..." 
  wget $DOWNLOAD_LINK -O vscode_latest.deb -q --show-progress 
  sudo dpkg -i vscode_latest.deb 
  rm vscode_latest.deb 
  echo "✅ Updated to latest version" 
fi