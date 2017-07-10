#!/bin/bash
set -e

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WORKING_DIR=$(dirname "$SCRIPTS_DIR")
INPUT_DIR="$WORKING_DIR/input"
OUTPUT_DIR="$WORKING_DIR/output"
LOG_DIR="$WORKING_DIR/logs"

if [ ! -d "$INPUT_DIR" ]; then
	echo "No input file directory found."
	echo "Users must place their input files in the ~/computations/input/ directory."
	exit
fi

# Setup folders if they don't already exist
mkdir -p "$OUTPUT_DIR"
mkdir -p "$LOG_DIR"

check_for_jobs()
{
	echo ""
	cd "$INPUT_DIR"

	# Find input files
	INPUT_NAMES=()
	while IFS=  read -r -d $'\0'; do
		# Remove the leading .
		INPUT_NAME=${REPLY##*/}
		INPUT_NAME=${INPUT_NAME%.*}
		INPUT_NAMES+=("$INPUT_NAME")
	done < <(find . -type f -print0)

	# Submit new job if input file has no corresponding output file
	num_jobs=0
	for input_name in "${INPUT_NAMES[@]}"; do
		if [ ! -e "$OUTPUT_DIR/$input_name.out" ]; then
			if submit_job "$INPUT_DIR/$input_name.inp"; then
				num_jobs=$((num_jobs + 1))
			fi
		fi
	done

	echo ""
	echo "$num_jobs jobs submitted."
	echo "Checkpoint, output, and log files will be placed under:"
	echo "$WORKING_DIR/"
	echo "Use the following command to check on your job queue:"
	echo '	qstat -u $USER'
}

submit_job()
{
	INPUT_FILE="$1"

	JOB_NAME=${INPUT_FILE##*/}
	JOB_NAME=${JOB_NAME%.*}

	# Check if input file exists
	if [ ! -e "$INPUT_FILE" ]; then
		echo "The provided input file could not be found."
		echo "	$INPUT_FILE"
		return 1
	fi

	# Check if job already exists
	if qstat -u $USER | grep -q -w "$JOB_NAME"; then
		echo "A job named $JOB_NAME is already in the queue."
		return 1
	fi

	echo "Submitting job named $JOB_NAME"

	# Try e-mail on finish? (-M)

	# Call the job script with the given arguments
	qsub -N "$JOB_NAME" -o "$LOG_DIR/$JOB_NAME.log" -d "$WORKING_DIR" -F "$INPUT_FILE" "$SCRIPTS_DIR/gaussian.pbs"

}

check_for_jobs
