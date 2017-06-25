# auto_pbs

The purpose of this repo is to simplify/automate setup and submission
of Portable Batch System (PBS) jobs. The script is designed to best serve PBS
jobs that do some form of calculations such as [guassian](http://gaussian.com/running/).

# Installing the Script

1. Login to the server used to submit PBS jobs.
2. Clone this repo to your home directory using the following command:
    ```
    git clone https://github.com/icolwell/auto_pbs.git
    ```

# Quickstart

To get up and running quickly, simply place gaussian input (.inp) files in the `~/computations/input/` directory and then run the script using the the following command.
```
bash ~/auto_pbs/submit_jobs.bash
```

## Note about input files

Do not place any `%Chk=` directives in the input file, checkpoint files are handled
automatically by the script.
