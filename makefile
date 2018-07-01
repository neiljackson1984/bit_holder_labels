buildDirectory=build
# buildDirectory:=$(shell mktemp --directory --dry-run)
inputFile=labels.tex
texOutputFile=${buildDirectory}/labels.pdf
tiledOutputFile=$(basename ${texOutputFile})-tiled.pdf
#this is what TexStudio view by default.
viewableOutputFile=$(basename ${inputFile}).pdf
allOutputPdfFiles=$(foreach texFile,$(wildcard ./*.tex), ${buildDirectory}/$(basename $(notdir ${texFile})).pdf)

# default:${texOutputFile}

default: ${allOutputPdfFiles} ${tiledOutputFile}

${tiledOutputFile}: ${texOutputFile} tile.php makefile
	php tile.php --inputPdfFile="$(shell cygpath --windows $(abspath ${texOutputFile}))" --outputPdfFile="$(shell cygpath --windows $(abspath ${tiledOutputFile}))" --outputPageWidth=8.5inch --outputPageHeight=11inch --outputPageLeftMargin=1inch --outputPageRightMargin=1inch --outputPageTopMargin=1inch --outputPageBottomMargin=1inch --dividerLineThickness=0.0004in

${buildDirectory}/%.pdf:%.tex ${buildDirectory}
	miktex-xetex --quiet --undump=xelatex --interaction=nonstopmode --aux-directory="$(shell cygpath --windows $(abspath ${buildDirectory}))" --output-directory="$(shell cygpath --windows $(abspath $(dir ${@})))" --job-name="$(basename $(notdir ${@}))" "$(shell cygpath --windows $(abspath ${<}))"
    
 
# @# echo target is ${@}
# @# echo first prerequisite is ${<} 
#  automatic variables reminder:
#   $@ -- this is the target (i.e. the thing that we are making)
#   $< -- this is the the first prerequisite.


# ${texOutputFile}: ${inputFile} ${buildDirectory}
# @# miktex-xetex --quiet --undump=xelatex --interaction=nonstopmode --output-directory=\"$tempDirectory\" --aux-directory=\"$tempDirectory\"" ." ". "\"$texFile\" 
# miktex-xetex --quiet --undump=xelatex --interaction=nonstopmode --aux-directory="$(shell cygpath --windows $(abspath ${buildDirectory}))" --output-directory="$(shell cygpath --windows $(abspath $(dir ${texOutputFile})))" --job-name="$(basename $(notdir ${texOutputFile}))" "$(shell cygpath --windows $(abspath ${inputFile}))"
	
${buildDirectory}:
	echo making the build directory: ${buildDirectory}
	mkdir --parents ${buildDirectory}
	
# .SILENT:
	

	
	
#untiledPsFile=$(basename ${texOutputFile}).ps
#tiledPsFile=$(basename ${texOutputFile})-tiled.ps
# @# pdftops -paper match "$(shell cygpath --windows $(abspath ${texOutputFile}))" "$(shell cygpath --windows $(abspath ${untiledPsFile}))"
# @# # pstops -q -d0.0 -w9mm -h12mm "$(shell cygpath --windows $(abspath ${untiledPsFile}))" "$(shell cygpath --windows $(abspath ${tiledPsFile}))"
# @# psnup -w8.5in -h11in -d0.001in -W0.9cm -H1.2cm -m0 -b0 -s1 -20 -q "$(shell cygpath --windows $(abspath ${untiledPsFile}))" "$(shell cygpath --windows $(abspath ${tiledPsFile}))"
# @# gswin64 -q -sPAPERSIZE=letter -dSAFER -dNOPAUSE -dBATCH -sOutputFile="$(shell cygpath --windows $(abspath ${tiledOutputFile}))"  -sDEVICE=pdfwrite  -c .setpdfwrite -f "$(shell cygpath --windows $(abspath ${tiledPsFile}))"
	