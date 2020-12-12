# alfred-rdm
This is a simple Alfred workflow to to change resolutions on your Mac. It invokes the command-line utility bundled within [avibrazil](https://github.com/avibrazil)'s [RDM](https://github.com/avibrazil/RDM) app.

The workflow was taken directly from [Dan Schlosser's website](https://schlosser.io), which has some other nifty [workflows](https://schlosser.io/lists/must-use-alfred-workflows/). I made/uploaded this version because Dan's workflow didn't behave as expected for some resolutions on my monitor--the output from the CLI tool indicated that the scale option ("-s") was causing problems. This workflow differs from Dan's in that it leaves out the scale option and assumes Retina/HDPI.

## Usage

Type "res" into Alfred to start the workflow. The listed resolutions can be found in the resolutions.txt file within the workflow directory. You can get to it by right-clicking the workflow on Alfred's "Workflows" tab and selecting "Show in Finder". I'm currently using this on my LG Ultrafine 27" so if you have that (or a 27" iMac) you should be okay without editing the file.