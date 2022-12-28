Processed images are from the MLI_old\MLI_old_D0_TIFF and MLI_old\MLI_old_D7_TIFF  folder on the OneDrive shared by Brad Smith.  				
				
				
				
The images are saved as i-j.tif where we refer to i as slide and j as subslide in this spreadsheet. All entries with the same slide number belong to the same animal ID.				
				
				
				
We use unique indices to identify the metrics associated with each image. To go from an index value to the i-j.tiff format, (i refers to slide & j to sublisde), we use the following equations:                                               for day 0 images:                   i = floor[index/13]+1   & j = mod(index,13)+1  for day 7 images:                   i = floor[index/13]-23  & j = mod(index,13)+1 				
				
				
				
				
To calculate an index value from the i-j.tiff format, (i refers to slide & j to sublisde), we use the folowing formula: index = (i-1)*13+(j-1) for day 0, and for day 7  index = (i+23)*13+(j-1) 				
				
				
				
				
all units of metrics reported in this spreadsheet are in pixels.				
the values in column area of tissue sei correspond to pruning the areas using a structuring element of radius 6.8*5*i pixels, where i is an integer between 1 and 10.				
				
				
				