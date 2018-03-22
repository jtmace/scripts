#mencoder dvd://1 -aid 128 -ofps 23.976 -ovc lavc -lavcopts vcodec=mpeg4:mbd=2:trell:vbitrate=1000:vpass=1 -oac mp3lame -lameopts br=128:cbr:vol=8 -vf cropdetect dvd://1 -o /dev/null
#mencoder dvd://1 -aid 128 -ofps 23.976 -ovc lavc -lavcopts vcodec=mpeg4:mbd=2:trell:vbitrate=1000:vpass=2 -oac mp3lame -lameopts br=128:cbr:vol=8 -vf cropdetect dvd://1 -o movie.avi

AUDIO_ID=128			 # always seems English is 128
FRAMES_PER_SEC="23.976"		 # default NTSC DVD framerate
VIDEO_BITRATE="-960000" 	 # -1000000 should produce a movie of about 1GB in size.
AUDIO_BITRATE=128		       
VOLUME=8	                 # 1-10
ASPECT="16:9"		         # Set this according to the movie, most new will be 16x9, most old will be 3:4
CROP="720:480:0:0"        	 # Figure this by running:
				 #    `mplayer -ss 60 -vf cropdetect dvd://1`

mencoder dvd://1 -aspect $ASPECT -aid $AUDIO_ID -ofps $FRAMES_PER_SEC -ovc xvid -xvidencopts pass=1:bitrate=$VIDEO_BITRATE -vf crop=$CROP -oac mp3lame -lameopts br=$AUDIO_BITRATE:cbr:vol=$VOLUME -o /dev/null
mencoder dvd://1 -aspect $ASPECT -aid $AUDIO_ID -ofps $FRAMES_PER_SEC -ovc xvid -xvidencopts pass=2:bitrate=$VIDEO_BITRATE -vf crop=$CROP -oac mp3lame -lameopts br=$AUDIO_BITRATE:cbr:vol=$VOLUME -o movie.avi
