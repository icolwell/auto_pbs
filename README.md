# auto_slurm

The purpose of this repo is to simplify setup and submission of SLURM jobs. This 
script is currently designed to run SLURM jobs doing [gaussian](http://gaussian.com/running/) 
calculations. If you are interested in how the scripts work, see the [README](scripts/README.md) 
in the scripts section.

# Installing the Script

1. Login to the server used to submit SLURM jobs.
2. Clone this repo using the following command:
```
git clone https://github.com/CurtisColwell/auto_slurm.git
```

# Running the Script

Simply place gaussian input (.inp) files in the `auto_slurm/input/` directory and
run the script using the following command.
```
bash auto_slurm/scripts/submit_gaussian.bash
```
A test input file of a hydrogen molecule is included. Run this first to ensure
everything is working properly. Output, checkpoint and formatted checkpoint
files will be generated in the output directory. A log showing the steps
performed by the script will be available in the log directory.

### Note about input files

Do not place `%Chk=` directives at the top of the input file. Checkpoint files
are handled automatically by the script.
