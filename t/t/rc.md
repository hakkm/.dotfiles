rc in rc.md stands for rare  commands

## recording screen
ffmpeg -f x11grab -i :0.0 vids/rec/out.mkv

# recording output audio
pactl list short sources  ;;			      *			;; get the id of the output. it is 0
ffmpeg -f x11grab -i :0.0 -ac 1 -ar 44100 -f pulse -i 0 out.mkv -y
                                                      *			 ;; is the id of the output
		                                                **     	 ;; overwrite without asking
 				*********                              	 ;; frequency     	


## formating a partition
sudo mkfs -t ext4 /dev/sdb1

## Wipe a Hard Drive
sudo shred -vzn 3 /dev/sdX
              ***		;; number of passes you can do just `-vz /dev/sdX` for one pass

## Burn an os to usb
sudo dd bs=4M if=/path/to/file.iso of=/dev/sdX status=progress oflag=sync
     				   	     *	    	       			;; the disk not the partition

## Brave shortcuts
brave://extensions/shortcuts

## formatting a partition to ntfs
sudo mkfs.ntfs /dev/sdxX

### Verify formatting 
sudo fsck /dev/sdxX



