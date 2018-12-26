archive_name="Workspace($(hostname)).zip"
workspace_path="/home/smdslim/Workspace"
temp_path="/media/smdslim/SECONDARY/Temp"
archive_remote_path="/Documents/WorkspaceBackups/$archive_name"
checksum_remote_path="/Documents/WorkspaceBackups/$archive_name.hash"
obtain_upload_url="https://cloud-api.yandex.net/v1/disk/resources/upload?path=$archive_remote_path&overwrite=true"
obtain_upload_hash_url="https://cloud-api.yandex.net/v1/disk/resources/upload?path=$archive_remote_path.hash&overwrite=true"
obtain_download_url="https://cloud-api.yandex.net/v1/disk/resources/download?path=$checksum_remote_path"
log_path="/home/smdslim/.logs/yandex.disk.log"
do_upload="NO"

echo "### BACKUP TASK STARTED ###"
echo "$(date) ### BACKUP TASK STARTED ###" >> "$log_path"

# Archive workspace to temp folder
echo "Making archive"
echo "$(date) Making archive" >> "$log_path"

cd "$temp_path"
# -FS to rewrite archive data
zip -q -FSr "$archive_name" "$workspace_path"

checksum=$( sha1sum "$temp_path/$archive_name")
touch "$temp_path/$archive_name.hash"
echo "$checksum" > "$temp_path/$archive_name.hash"
# echo "Checksum is: $checksum"

echo "Checking remote hash"
echo "$(date) Checking remote hash" >> "$log_path"
# echo "$obtain_download_url"; exit
# Get download link (OAuth key work 1 year - generated on 17.12.2018)
response=$( curl -s -H "Authorization: OAuth AQAAAAAAp-U9AAVava7Wl90rPUn0ln9kDyhywA8" "$obtain_download_url" )
error=$(echo "$response" | php -r "echo @json_decode(file_get_contents('php://stdin'))->error == NULL ? 'NO' : 'YES';")

if [ "$error" = 'YES' ]; then
	do_upload='YES'
	echo "No remote hash file found (will be uploaded)"
	echo "$(date) No remote hash file found (will be uploaded)" >> "$log_path"
else
	url=$( curl -s -H "Authorization: OAuth AQAAAAAAp-U9AAVava7Wl90rPUn0ln9kDyhywA8" "$obtain_download_url" | python3 -c "import sys, json; print(json.load(sys.stdin)['href'])")
	remote_checksum=$( curl -s -o- "$url" )
	# echo "Remote checksum: $remote_checksum"
	if [ "$remote_checksum" != "$checksum" ]; then
		echo "Remote checksum is not equal to a local one"
		echo "$(date) Remote checksum is not equal to a local one" >> "$log_path"
		echo "$(date) Remote: '$remote_checksum'" >> "$log_path"
		echo "$(date) Local: $checksum" >> "$log_path"
		do_upload='YES'
	else
		echo "Local and remote hash files are equal"
	fi
fi

if [ "$do_upload" = 'YES' ]; then
	echo "Uploading archive"
	echo "$(date) Uploading archive" >> "$log_path"

	# Get upload link (OAuth key work 1 year - generated on 17.12.2018)
	url=$( curl -s -H "Authorization: OAuth AQAAAAAAp-U9AAVava7Wl90rPUn0ln9kDyhywA8" "$obtain_upload_url" | python3 -c "import sys, json; print(json.load(sys.stdin)['href'])")

	curl -s "$url" --upload-file "$temp_path/$archive_name"

	echo "Archive uploaded!"
	echo "$(date) Archive uploaded!" >> "$log_path"

	echo "Uploading hash file"
	echo "$(date) Uploading hash file" >> "$log_path"
	# Get hash file upload link
	url=$( curl -s -H "Authorization: OAuth AQAAAAAAp-U9AAVava7Wl90rPUn0ln9kDyhywA8" "$obtain_upload_hash_url" | python3 -c "import sys, json; print(json.load(sys.stdin)['href'])")

	curl -s "$url" --upload-file "$temp_path/$archive_name.hash"
	echo "Hash file uploaded"
	echo "$(date) Hash file uploaded" >> "$log_path"

	# Go back to initial folder
	cd -
else
	echo "No need to upload"
	echo "$(date) No need to upload" >> "$log_path"
fi

echo "### BACKUP TASK FINISHED ###"
echo "$(date) ### BACKUP TASK FINISHED ###" >> "$log_path"