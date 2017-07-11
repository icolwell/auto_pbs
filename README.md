# auto_pbs

The purpose of this repo is to simplify setup and submission of Portable Batch
System (PBS) jobs. This script is currently designed to run PBS jobs doing
[gaussian](http://gaussian.com/running/) calculations. If you are interested in
how the scripts work, see the [README](scripts/README.md) in the scripts
section. 

# Installing the Script

1. Login to the server used to submit PBS jobs.
2. Clone this repo using the following command:
  ```
  git clone https://github.com/icolwell/auto_pbs.git
  ```

# Running the Script

Simply place gaussian input (.inp) files in the `auto_pbs/input/` directory and
run the script using the following command.
```
bash auto_pbs/scripts/submit_gaussian.bash
```
A test input file of a hydrogen molecule is included. Run this first to ensure
everything is working properly. Output, checkpoint and formatted checkpoint
files will be generated in the output directory. A log showing the steps
performed by the script will be available in the log directory.

### Note about input files

Do not place `%Chk=` directives at the top of the input file. Checkpoint files
are handled automatically by the script.
