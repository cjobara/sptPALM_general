
dir1 = getDirectory("Choose Source Directory Left: ");
input = dir1;

dir2 = getDirectory("Choose Source Directory Right: ");
input2=dir2;

dir3 = getDirectory("Choose mask for ROI visualization: ");

list = getFileList(input);
list2 = getFileList(input2);
list3 = getFileList(dir3);

output=getDirectory("Choose Where Output Data Goes: ");

for (i = 0; i < list.length; i++) {
	filename1=list[i];
	filename2=list2[i];
	filename3=list3[i];

	setBatchMode(true);
	open(dir3+filename3);
	setAutoThreshold("Default dark");
	run("Convert to Mask");
	roiManager("reset");
	run("Analyze Particles...", "add");
	close();
	setBatchMode(false);

	open(input+filename1);	
	run("Set... ", "zoom=75");
	setLocation(400, 200);
	run("Set Scale...", "distance=0 known=0 unit=pixel");
	L=lengthOf(filename1);
	filebase=substring(filename1,0,L-14);
	roiManager("save", output+filebase+"_CSdensityROIs.zip");
	roiManager("Show None");

	open(input2+filename2);
	imID=getImageID();
	run("Size...", "width=683 height=683 depth=1 constrain average interpolation=None");
	
	//run("Set... ", "zoom=75");
	roiManager("Show All");
	run("Flatten");
	//setLocation(1000, 150, 950, 950);
	selectImage(imID);
	close();
	run("Size...", "width=1200 height=1200 depth=1 constrain average interpolation=None");
	run("Set... ", "zoom=75");
	run("Tile");

	roiManager("reset");
	setTool("multipoint");
	waitForUser("Check out this cell!");
	run("Set Measurements...", "centroid center stack redirect=None decimal=3");
	run("Measure");
	saveAs("Results", output+filebase+"CSsites.txt");
	roiManager("add");
	roiManager("save", output+filebase+"rois.zip");
	roiManager("reset");
	run("Clear Results");
	run("Close All");
}

