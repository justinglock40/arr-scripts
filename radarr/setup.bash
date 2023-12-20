#!/usr/bin/with-contenv bash
SMA_PATH="/usr/local/sma"

echo "************ install packages ************" && \
apk add -U --update --no-cache \
  flac \
  opus-tools \
  jq \
  git \
  wget \
  mkvtoolnix \
  python3-dev \
  libc-dev \
  py3-pip \
  gcc \
  ffmpeg \
  yt-dlp && \
echo "************ install python packages ************" && \
pip install --upgrade --no-cache-dir -U \
		excludarr \
		yq && \
echo "************ install recyclarr ************" && \
mkdir -p /recyclarr && \
wget "https://github.com/recyclarr/recyclarr/releases/latest/download/recyclarr-linux-musl-x64.tar.xz" -O "/recyclarr/recyclarr.tar.xz" && \
tar -xf /recyclarr/recyclarr.tar.xz -C /recyclarr &>/dev/null && \
chmod 777 /recyclarr/recyclarr
apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/community dotnet7-runtime

mkdir -p /custom-services.d
echo "Download QueueCleaner service..."
curl https://raw.githubusercontent.com/RandomNinjaAtk/arr-scripts/main/universal/services/QueueCleaner -o /custom-services.d/QueueCleaner
echo "Done"

echo "Download AutoConfig service..."
curl https://raw.githubusercontent.com/RandomNinjaAtk/arr-scripts/main/radarr/AutoConfig.service -o /custom-services.d/AutoConfig
echo "Done"

echo "Download AutoExtras service..."
curl https://raw.githubusercontent.com/RandomNinjaAtk/arr-scripts/main/radarr/AutoExtras.service -o /custom-services.d/AutoExtras
echo "Done"

echo "Download Recyclarr service..."
curl https://raw.githubusercontent.com/RandomNinjaAtk/arr-scripts/main/universal/services/Recyclarr -o /custom-services.d/Recyclarr
echo "Done"

echo "Download UnmappedFolderCleaner service..."
curl https://raw.githubusercontent.com/RandomNinjaAtk/arr-scripts/main/radarr/UnmappedFolderCleaner.bash -o /custom-services.d/UnmappedFolderCleaner
echo "Done"

mkdir -p /config/extended
echo "Download Script Functions..."
curl https://raw.githubusercontent.com/RandomNinjaAtk/arr-scripts/main/universal/functions.bash -o /config/extended/functions
echo "Done"

echo "Download Naming script..."
curl https://raw.githubusercontent.com/RandomNinjaAtk/arr-scripts/main/radarr/naming.json -o /config/extended/naming.json 
echo "Done"

mkdir -p /config/extended
echo "Download PlexNotify script..."
curl https://raw.githubusercontent.com/RandomNinjaAtk/arr-scripts/main/radarr/PlexNotify.bash -o /config/extended/PlexNotify.bash 
echo "Done"

echo "Download Extras script..."
curl https://raw.githubusercontent.com/RandomNinjaAtk/arr-scripts/main/radarr/Extras.bash -o /config/extended/Extras.bash 
echo "Done"

echo "Download SMA config..."
curl https://raw.githubusercontent.com/RandomNinjaAtk/arr-scripts/main/radarr/sma.ini -o /config/extended/sma.ini 
echo "Done"

echo "Download Recyclarr config..."
curl https://raw.githubusercontent.com/RandomNinjaAtk/arr-scripts/main/radarr/recyclarr.yaml -o /config/extended/recyclarr.yaml
echo "Done"

if [ ! -f /config/extended.conf ]; then
	echo "Download Extended config..."
	curl https://raw.githubusercontent.com/RandomNinjaAtk/arr-scripts/main/radarr/extended.conf -o /config/extended.conf
	chmod 777 /config/extended.conf
	echo "Done"
fi


chmod 777 -R /config/extended

exit
