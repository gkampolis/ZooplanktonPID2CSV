# Intro Comments ----------------------------------------------------------

# Purpose: A simple script to extract the measurement data from a .PID file and
# save it as .CSV developed in R.

# Author: Georgios Kampolis
# For: Marine Scotland Science
# Comments: Based on the work done for the prototype to automatically classify
# scanned zooplankton particles.


# Packages ----------------------------------------------------------------

## package management that takes care of loading and installing if necessary:
if (!require("pacman")) install.packages("pacman"); library(pacman)

# p_load below is equivalent to library (+install.packages if needed)
pacman::p_load(
  # Read and write data
  readr,
  # Notify when done
  beepr,
  update = FALSE
)


# Find folder with particle data ------------------------------------------


# Ask user for path to an existing folder with the .pid files on disk
rstudioapi::showDialog(
  title = "Prompt",
  message = "In the next dialog, please select the folder containing the .PID files."
)

# Get directory
pidDir <- rstudioapi::selectDirectory(
  caption = "Select directory with PID files.",
  label = "Select"
)

# Get names of .pid files in the directory
pidFiles <- base::list.files(pidDir, pattern = "*.pid$")

# Get path separator, depending on OS, to construct paths.
fileSep <- base::.Platform$file.sep


# Extract data and save as csv --------------------------------------------

if (length(pidFiles) < 1) {
  message("Directory doesn't contain any .pid files or other error.")
} else {
  
  # Iterate over all .pid files
  for (pidCounter in 1L:length(pidFiles)) {
    
    # Locate the "[Data]" flag in each .pid file
    readSkip <- grep(
      "\\[Data\\]",
      read_lines(
        paste0(pidDir,fileSep,pidFiles[pidCounter])
      )
    )
    
    # Read in data
    data <- read_delim(
      file = paste0(pidDir,fileSep,pidFiles[pidCounter]),
      delim = ";",
      col_names = TRUE,
      skip = readSkip
    )
    
    # Save as .csv
    write_csv(
      data,
      path = paste0(
        pidDir,fileSep,sub(".{4}$",".csv",pidFiles[pidCounter])
      )
    )
    
  }
}


# Notify user of script's end ---------------------------------------------



# Notify user in console
message("Converted files saved in orginal directory:")
message(pidDir)

# Throw dialog with the same information
rstudioapi::showDialog(
  title = "Script complete!",
  message = paste0(
    "Converted files saved in orginal directory: \n", pidDir
  )
)

message("Script complete!")
# Play sound to notify that the end of the script has been reached.
beepr::beep(1)