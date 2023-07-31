
//This program contains the old programs CJO-ERprep.ijm, CJO-MitoPrep.ijm, and UnmixingPrep.ijm.

//This will take a three channel nd2 and produce appropriately time averaged single-color tifs for
//channels 2 and 3, and produce a long time average version of all three channels to extract 
//spectral information from. 

//This program works upstream of the matlab program "ERsegmenter" and the imagej macro "CJO-MaskMitoCrude.ijm"
// to collectively produce the file structure and data for "UnmixingFileAssembly.ijm".

//Once all four of these programs have been run, data is assembled appropriately to run the matlab code "SpectralAnalysis.m"

//Choose the parent directory:
dir1 = getDirectory("Choose Source Directory: ");

//Define the input and output file locations
setBatchMode(true);
input = dir1 + "RawData/";
output = dir1;
list = getFileList(input);

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

for (i = 0; i < list.length; i++) {
	filename=list[i];
	run("Bio-Formats", "open=" + input + filename + " autoscale color_mode=Default view=Hyperstack stack_order=XYCZT");
	L=lengthOf(filename);
	filebase=substring(filename,0,L-4);
	run("Split Channels");
	InstSingleMolExtractor(input, filebase);
	CJO_ERprep(input, filebase);
	
	
	
}

function CJO_ERprep(input, filename) {
	
	selectImage(1);
	run("Median 3D...", "x=0 y=0 z=10");
	saveAs("Tiff", ERdir+filename+"_2.tif");
	run("Bleach Correction", "correction=[Simple Ratio]");
	saveAs("Tiff", HQer+filename+"_2_TA_BC.tif");
	close();
	selectImage(1);
	close();
}

function InstSingleMolExtractor(input, filename) {
	selectImage(1);
	saveAs("Tiff", HQdir+"SM/"+filename+"_SMinst.tif");
	run("Median 3D...", "x=0 y=0 z=10");
	saveAs("Tiff", particlesdir+filename+"_SM.tif");
	close();
}

