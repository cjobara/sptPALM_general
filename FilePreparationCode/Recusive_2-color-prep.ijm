
// "BatchProcessFolders"
//
// This macro batch processes all the files in a folder and any
// subfolders in that folder. In this example, it runs the Subtract 
// Background command of TIFF files. For other kinds of processing,
// edit the processFile() function at the end of this macro.

   requires("1.33s"); 
   dir1 = getDirectory("Choose a Directory ");
   setBatchMode(true);

	output = dir1;
	//Tell the program where the folders need to be
	SpecIndir=output + "SpectralInputs/";
	HQdir = output + "HighQuality/";
	HQer=HQdir+"Channel2/";

	particlesdir = SpecIndir + "Channel1/";
	ERdir = SpecIndir + "Channel2/";

	//Make folders to organize the final output:
	File.makeDirectory(output + "HighQuality/")
	File.makeDirectory(output + "SpectralInputs/")

	//Make the subfolders for the output

	File.makeDirectory(ERdir);
	File.makeDirectory(particlesdir);

	File.makeDirectory(HQer);
	File.makeDirectory(HQdir+"SM/");

   
   dir=dir1+ "RawData/";
   count = 0;
   countFiles(dir);
   n = 0;
   processFiles(dir);
   //print(count+" files processed");
   
   function countFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              countFiles(""+dir+list[i]);
          else
              count++;
      }
  }

   function processFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              processFiles(""+dir+list[i]);
             
          else {
             showProgress(n++, count);
             path = dir+list[i];
             processFile(path);
          }
      }
  }


   function processFile(path) {
       if (endsWith(path, ".nd2")) {
           open(path);
           L=lengthOf(path);
		   filebase=substring(path,0,L-4);
			run("Split Channels");
			InstSingleMolExtractor(filebase);
			CJO_ERprep(filebase);
           run("Close All");
      }
  }



function CJO_ERprep(filebase) {
	
	selectImage(1);
	run("Median 3D...", "x=0 y=0 z=10");
	saveAs("Tiff", filebase+"_2.tif");
	run("Bleach Correction", "correction=[Simple Ratio]");
	saveAs("Tiff", filebase+"_2_TA_BC.tif");
	close();
	selectImage(1);
	close();
}

function InstSingleMolExtractor(filebase) {
	selectImage(1);
	saveAs("Tiff", filebase+"_SMinst.tif");
	run("Median 3D...", "x=0 y=0 z=10");
	saveAs("Tiff", filebase+"_SM.tif");
	close();
}