# ZooplanktonPID2CSV
A simple `.pid` to `.csv` converter, written in R. 

###### Note
This was developed with the `.pid` generated during the zooplankton scanning process in mind, as implemented by Marine Scotland, and may not generalize as is beyond that context. Functionality is dependant on data being delimited by ";" and the existence of a `[Data]` flag within the `.pid` file. That said, it is trivial to amend the script to account for any such differences.

## Usage
Simple double click on the `.Rproj` file to launch RStudio and then source the `Main.R` script. Dialogs will appear on the screen to guide the user of the very simple steps:

* Locate folder where `pid` files reside.
* Notify user of script's end

Extracted data sets in `.csv` format now exist side by side with the original files in the same directory. Filtering by file type within the folder to select only the `.csv` files is recommended.

## Notes
 The key functionality is the automatic detection of the `[Data]` flag inside `.pid` files via regular expressions. The user does not have to provide the line number of where that flag is located, especially useful given that it is not the same in all `.pid` files.

 Furthermore, the script is able to distinguish between `.pid` and other files, targeting `.pid` exclusively.
