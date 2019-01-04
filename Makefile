DIR1=verilog_dir
DIR2=build_dir
BSC_FLAGS=-aggressive-conditions -show-schedule -bdir build_dir -simdir $(DIR2) -vdir $(DIR1) -info-dir $(DIR2)
.PHONY: all clean CommunicationInterface Download ConnectionSynthesis ProbabilityAnalysis Test#Used to list all of the bsv files and download options

#execute all of the needed parts
all: CommunicationInterface Test

#bsv template for single cycle
CommunicationInterface:

	mkdir -p build_dir
	mkdir -p verilog_dir
	bsc $(BSC_FLAGS) -sim -u -g mkInterface CommunicationInterface.bsv
	bsc $(BSC_FLAGS) -verilog -u -g mkInterface CommunicationInterface.bsv
	bsc $(BSC_FLAGS) -sim -u -e mkInterface -o  CommunicationInterface
	#iverilog -o $(DIR1)/mkInterface.vvp $(DIR1)/mkInterface.v #added the simulation files

ConnectionSynthesis:
	mkdir -p build_dir
	mkdir -p verilog_dir
	bsc $(BSC_FLAGS) -sim -u -g mkConnections ConnectionSynthesis.bsv
	bsc $(BSC_FLAGS) -verilog -u -g mkConnections ConnectionSynthesis.bsv
	bsc $(BSC_FLAGS) -sim -u -e mkConnections -o ConnectionSynthesis
	#iverilog -o $(DIR1)/mkConnections.vvp $(DIR1)/mkConnections.v
 NodeExtraction:
	 mkdir -p build_dir
	 mkdir -p verilog_dir

 ProbabilityAnalysis:
	mkdir -p build_dir
	mkdir -p verilog_dir
	bsc $(BSC_FLAGS) -sim -u -g mkAnalysis ProbabilityAnalysis.bsv
	bsc $(BSC_FLAGS) -verilog -u -g mkAnalysis ProbabilityAnalysis.bsv
	bsc $(BSC_FLAGS) -sim -u -e mkAnalysis -o ProbabilityAnalysis

 Test:
	 mkdir -p build_dir
	 mkdir -p verilog_dir
	 bsc $(BSC_FLAGS) -sim -u -g mkTest Tests.bsv
	 bsc $(BSC_FLAGS) -verilog -u -g mkTest Tests.bsv
	 bsc $(BSC_FLAGS) -sim -u -e mkTest -o mkTest FileIo.cpp


 Download:
	 #download iverilog
	 apt-get install iverilog

 clean:

	 @echo Cleaning the Files
 	 #Maybe don't delete all of the verilog files in the directory
	 #rm -rf *.v *.bo *.ba *.cxx *.o *.h *.so
	 rm -rf build_dir
