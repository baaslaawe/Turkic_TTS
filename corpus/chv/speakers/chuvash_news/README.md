# Data for Chuvash TTS

## Prerequisites

* From Debian/Ubuntu: sudo apt-get install python3-pip python3-numpy python3-scipy python3-sklearn; sudo pip3 install pydub eyeD3 hmmlearn


## Procedure for extracting training data

1. 

In the ./audio/proc subdirectory, run the ../../scripts/clean_audio.sh script. This will 
read audio from ./audio/orig directory and generate cleaned audio in the ./audio/proc directory. It will
also remove the first 3 seconds and the last 3 seconds from the files.

2. 

Again in the ./audio/proc subdirectory run the ../../scripts/segment_audio.sh script. This 
will take the clean files, run them through the audio_segmenter.py script, and then 
split them using sox. The output files are in ./audio/split

3. 

In the ./ directory, run ./scripts/extract_training.sh with an argument of the output directory. This will
copy the sentence and audio for that sentence into separate files with the same prefix but different 
suffixes in the output directory. It will only include those files which are compatible in terms of how
many sentences and audio segments there are.

## Procedure for adding manual segmentation

Sometimes the automatic segmentation does not align properly with the text. In this case 
you can specify the manual segmentation in `./audio/manual`. The manual segmentation
should be in the same format as the output of the automatic segmenter.



