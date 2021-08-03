## Sashimi plots

RNA-Seq densities along the exons were plotted using the `sashimi_plot` function included in the MISO package (misopy 0.5.4). In the sashimi plot, introns are scaled down by a factor of 15 and exons are scaled down by a factor of 5 (settings/sashimi_plot_settings.txt). RNA-Seq read densities across exons are scaled by the number of mapped reads in the sample and are measured in RPKM units. Slight modifications were made to “plot_gene.py” and “plot_settings.py” within the sashimi_plot directory of the MISO package to highlight the RNA-Seq density plot. The updated sashimi_plot directory is provided. 



* MISO (misopy-0.5.4.tar.gz) was installed using the command `pip install misopy`.    
* 

* The documentation for `sashimi_plot` is at https://miso.readthedocs.io/en/fastmiso/sashimi.html.  

* The GFF annotation file for the exon20-21 region of UNC13A is provided in the gff directory. The indexed GFF files are in `gff/indexed`

* The command for making the plot: `sashimi_plot --plot-event "chr19:17642845:17642960:-@chr19:17642414:17642591:-@chr19:17641393:17641556:-" event_data/indexed/ settings/sashimi_plot_settings.txt --output-dir coverage_plot`
