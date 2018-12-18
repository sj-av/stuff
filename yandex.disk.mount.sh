output=$( cat /proc/mounts | grep yandex )

if [[ $output == *"yandex"* ]]
	then
    
  		echo "Yandex disk mounted"
  		# Archive workspace to temp folder
  		echo "Making archive"
  		notify-send 'Workspace backup: makin archive'
  		cd /media/smdslim/SECONDARY/Temp
  		zip -q -FSr Workspace.zip /home/smdslim/Workspace
  		
  		echo "Copying archive"
  		notify-send 'Workspace backup: copying to yandex disk'
  		# Copy archive to yandex disk
  		cp ./Workspace.zip /media/smdslim/yandex.disk/Documents/Workspace.zip

  		# Go back to initial folder
  		echo "Going back"
  		cd -
  		notify-send 'Backup finished'
	else
		echo "Yandex disk is not mounted"
fi
