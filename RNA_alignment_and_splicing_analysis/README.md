## Running the RNA-seq pipeline
 `./sh_RNAseq.sh </path/to/fastq(.gz)/folder> </path/to/destination/folder> hg38_RNAseq.ini`   (Adapted from https://github.com/emc2cube/Bioinformatics). 
Annotation files for hg38 are provided in the reference_files folder. Other reference files are not provided due to the file size limit.

## Visualization in Voila
 The Voila App can be downloaded from https://majiq.biociphers.org/app_download/
 The instruction for using Voila can be found at  https://biociphers.bitbucket.io/majiq/VOILA_app.html
 Files needed for using Voila are in the majiq/voila_files folder.
 
## Visualization in Leafcutter
  Visualization of the Leafcutter results would require SSH tunneling if .\/run_leafviz.R \*.RData is run on an HPC cluster. 
  The instruction for doing this on a SLURM based cluster is as following (adapted from https://hpc-training.sdsc.edu/notebooks-101/Docs/source/methods/tunneling.html):
  1. Open two terminals on your computer
  2. SSH into HPC from your command using command `ssh user@...`
  3. Claim an interactive node: `srun ...`
  4. Run the command on the interactive node: `./run_leafviz.R /control_vs_TDP_negative.RData`. You will see something like ```Listening on http://127.0.0.1:7368
Couldn't get a file descriptor referring to the console``` at the end of the output. The number following `http;//127.0.0.1: ` may be different.
  5. Create SSH Tunnel Connection. In the second terminal, type in `ssh -L 7368:localhost:7368 -t user@...`. Replace 7368 wtih the number following `http;//127.0.0.1: `
  6. In the new SSH window,run: `ssh -L 7368:localhost:7368 InterativeNode`. Replace InteractiveNode with the name of the interative node claimed in Step 3. 
  7. Copy and paste `http://127.0.0.1:7368` to any browser. Replace 7368 wtih the number following `http;//127.0.0.1: `
  
  
