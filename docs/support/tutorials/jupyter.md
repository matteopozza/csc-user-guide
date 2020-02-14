# Using Jupyter notebooks in Puhti

Jupyter notebooks can be used in Puhti by launching a Jupyter notebook server in
a compute node and connecting then with a web browser running on local machine.

## Starting a notebook server

Several modules include **Jupyter**, such as **python-env**,
[python-data](../../apps/python-data.md) and
[tensorflow](../../apps/tensorflow.md). In order to start a Jupyter notebook
server, submit a following batch job (edit project, time and memory
requirements etc. as needed, and choose a proper **module** for your tasks):

```
#!/bin/bash
#SBATCH --job-name=jupyter
#SBATCH --account=<project>
#SBATCH --partition=small
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=4G
#SBATCH --mail-type=BEGIN  # Get email notification when job starts
#SBATCH --mail-user=<your email address>
#SBATCH --output=jupyter-job.%J.out

module load python-env

XDG_RUNTIME_DIR=""
NODENAME=$(hostname)

## print tunneling instructions 
echo -e "
    Copy/Paste this in your local terminal to ssh tunnel with remote
    -----------------------------------------------------------------
    ssh -N -L 8899:localhost:8899 -J $USER@puhti.csc.fi $NODENAME
    -----------------------------------------------------------------

"

## start jupyter server
srun jupyter notebook --no-browser --port=8899
```

## Setting up ssh tunnel

In order to connect a local web browser to Jupyter notebook server,
you need to setup a ssh tunnel from your local workstation into the
compute node.

### Linux and Mac

Once the job has started, copy-paste the correct ssh command from the
beginning of the job output file (`jupyter-job.xxxx.out` where xxxx is
the job id), *i.e.*

```bash
ssh -N -L 8899:localhost:8899 -J ...
```

### Windows

FIXME

## Connecting with web browser

Once the ssh connection has been established, you can copy/paste the
URL in the end of the job output file (`jupyter-job.xxxx.out` where xxxx is
the job id) into your browser. The URL has the form `http://localhost:8899/?token=...`.
