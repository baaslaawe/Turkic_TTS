# Produce training data and output to a directory
# Only include those files where the number of audio 
# segments matches the number of sentences in the text

output_dir=$1

if [[ $# -lt 1 ]]; then
	echo "bash scripts/extract_training.py <target directory>"
	exit;
fi

for id in `cat track-id-list.txt`; do
	if [[ ! -f transcripts/txt/$id.txt ]]; then
		continue
	fi
	nf=`ls audio/split/trim_clean_$id.*.flac 2>/dev/null| wc -l`;
	if [[ $nf -eq 0 ]]; then
		continue;
	fi
	txt_sent_no=`cat transcripts/txt/$id.txt | wc -l`;
	audio_files_no=`ls -1 audio/split/trim_clean_$id.*.flac | wc -l`
	echo $id" "$txt_sent_no" "$audio_files_no;

	if [[ $txt_sent_no -eq $audio_files_no ]]; then
		for sid in `cat transcripts/txt/$id.txt | cut -f1`; do 
			cat transcripts/txt/$id.txt | grep -P "^$sid\t" | cut -f2 > $output_dir/$id.$sid.txt
			sox audio/split/trim_clean_$id.$sid.flac $output_dir/$id.$sid.wav
		done	
	fi
done

