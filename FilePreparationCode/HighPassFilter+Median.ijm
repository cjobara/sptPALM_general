// "BatchProcessFolders"
//
// This macro batch processes all the files in a folder and any
// subfolders in that folder. In this example, it runs the Subtract 
// Background command of TIFF files. For other kinds of processing,
// edit the processFile() function at the end of this macro.

   requires("1.33s"); 
   dir = getDirectory("Choose a Directory ");
   setBatchMode(true);
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
       if (endsWith(path, ".tif")) {
           open(path);
           L=lengthOf(path);
		   filebase=substring(path,0,L-4);
		   t1=getTitle();
		   run("Duplicate...", "duplicate");
		   t2=getTitle();
		   run("Gaussian Blur...", "sigma="+60+" stack");
		   imageCalculator("Subtract create 32-bit stack", t1, t2);
		   run("Median 3D...", "x=0 y=0 z=10");
           saveAs("Tiff", filebase+"_maxS2N.tif");
           run("Close All");
      }
  }
