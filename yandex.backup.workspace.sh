archive_name="Workspace($(hostname)).zip"
workspace_path="/home/smdslim/Workspace"
temp_path="/media/smdslim/SECONDARY/Temp"
remote_path="/Documents/$archive_name"
obtain_url="https://cloud-api.yandex.net/v1/disk/resources/upload?path=$remote_path&overwrite=true"
log_path="/home/smdslim/.logs/yandex.disk.log"

# Archive workspace to temp folder
echo "Making archive"
echo "$(date) Making archive" >> "$log_path"

cd "$temp_path"
# -FS to rewrite archive data
zip -q -FSr "$archive_name" "$workspace_path"

echo "Uploading archive"
echo "$(date) Uploading archive" >> "$log_path"

# Get upload link (OAuth key work 1 year - generated on 17.12.2018)
url=$( curl -s -H "Authorization: OAuth AQAAAAAAp-U9AAVava7Wl90rPUn0ln9kDyhywA8" "$obtain_url" | python3 -c "import sys, json; print(json.load(sys.stdin)['href'])")

curl -s "$url" --upload-file "$temp_path/$archive_name"

echo "Archive uploaded!"
echo "$(date) Archive uploaded!" >> "$log_path"

# Go back to initial folder
cd -
