archive_name="Workspace($(hostname)).zip"
workspace_path="/home/smdslim/Workspace"
temp_path="/media/smdslim/SECONDARY/Temp"
remote_path="/Documents/$archive_name"
obtain_url="https://cloud-api.yandex.net/v1/disk/resources/upload?path=$remote_path&overwrite=true"

# Archive workspace to temp folder
echo "Making archive"
notify-send 'Workspace backup: making archive'
cd "$temp_path"
# -FS to rewrite archive data
zip -q -FSr "$archive_name" "$workspace_path"

echo "Uploading archive"
notify-send 'Workspace backup: uploading archive to Yandex.Disk'

# Get upload link (OAuth key work 1 year - generated on 17.12.2018)
url=$( curl -s -H "Authorization: OAuth AQAAAAAAp-U9AAVava7Wl90rPUn0ln9kDyhywA8" "$obtain_url" | python3 -c "import sys, json; print(json.load(sys.stdin)['href'])")

curl -s "$url" --upload-file "$temp_path/$archive_name"

echo "Archive uploaded!"
notify-send 'Workspace backup: archive uploaded'

# Go back to initial folder
cd -
