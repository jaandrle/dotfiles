#!/usr/bin/env bash

url_api="https://commons.wikimedia.org/w/api.php"
today=$(date +%Y-%m-%d)

file_image=$(curl -s "$url_api" \
	--data-urlencode "action=expandtemplates" \
	--data-urlencode "prop=wikitext" \
	--data-urlencode "text={{Potd/$today}}" \
	--data-urlencode "format=json" \
	| jq -r '.expandtemplates.wikitext'
)
if [[ -z "$file_image" ]]; then
	echo "Error: Could not fetch POTD filename for $today" >&2
	exit 1
fi

echo -e "$(curl -s "$url_api" \
	--data-urlencode "action=expandtemplates" \
	--data-urlencode "prop=wikitext" \
	--data-urlencode "text=CS\n{{Potd/$today (cs)}}\n\n EN\n{{Potd/$today (en)}}\n" \
	--data-urlencode "format=json" \
	| jq -r '.expandtemplates.wikitext')"

encoded_filename=$(printf '%s' "$file_image" | jq -sRr @uri)
url_image="https://commons.wikimedia.org/wiki/Special:FilePath/$encoded_filename"
file_wallpaper="potd.jpg"
echo "Downloading POTD: $url_image"
if curl -Ls -o "$HOME/storage/downloads/$file_wallpaper" "$url_image"; then
	echo "Setting wallpaper..."
	am start \
		-a android.intent.action.ATTACH_DATA \
		-t "image/*" \
		-d "file:///storage/emulated/0/Download/$file_wallpaper" \
		-n deckers.thibault.aves.libre/deckers.thibault.aves.WallpaperActivity \
		--es "set_as" "wallpaper" \
		--ez "crop" false \
		--ei "which" 1  # 1 = home screen, 2 = lock screen, 3 = both
	echo "Wallpaper updated successfully!"
else
	echo "Error: Failed to download image" >&2
	exit 1
fi
