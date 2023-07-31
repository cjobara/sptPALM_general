dir1 = getDirectory("Choose Source Directory: ");

input = dir1+"Density1D/";
list = getFileList(input);

output = dir1 + "Mask/";
File.makeDirectory(output);


for (i = 0; i < list.length; i++) {
	filename=list[i];
	L=lengthOf(filename);
	filebase=substring(filename,8,L-11);
	MaskMito(input, filename);
	}

function MaskMito(input, filename) {
	open(input+filename);
	setLocation(400, 200);
	run("Cyan Hot");
	
	open(dir1+"Overlay/"+filebase+"_Tracks_tracks.tif");
	setLocation(400, 200);
	
	//run("Set... ", "zoom=400");
	//run("Duplicate...", "duplicate");
	open(input+filename);
	setLocation(1000, 200);
	iD=getTitle();
	//run("Set... ", "zoom=400");
	
	setAutoThreshold("Default dark");
	run("Threshold...");
	waitForUser("Apply threshold, then hit OK");
	selectWindow(iD);
	setOption("BlackBackground", false);
	run("Convert to Mask", "method=Default background=Dark");

	waitForUser("Adjust the mask until you are happy with it.");
	selectWindow(iD);
	run("Invert LUT");
	saveAs("Tiff", output+filebase+"_Mask.tif");
	run("Close All");
}
