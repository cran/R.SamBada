## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- packages, eval=FALSE----------------------------------------------------
#  install.packages("BiocManager")
#  BiocManager::install(pkgs=c("SNPRelate","biomaRt")) #if asked, please update packages that needs to be updated
#  install.packages("R.SamBada", dependencies=c("Depends",
#        "Imports", "LinkingTo", "Suggests"))
#  library("R.SamBada")

## ---- eval=FALSE--------------------------------------------------------------
#  #Load help
#  ?downloadSambada()
#  #Downloads Sambada into the temporary directory
#  downloadSambada(tempdir())

## ---- eval=FALSE--------------------------------------------------------------
#  #Loads data
#  #================
#  #These files are distributed within your package. The system.file will return the full path to them. With your data, you can just use the name of the file, provided the file is in the active directory
#  genoFile=system.file("extdata", "uganda-subset-mol.ped", package = "R.SamBada")
#  genoFile #Check the path to the file
#  
#  #Load help
#  #================
#  ?prepareGeno
#  
#  #Run prepareGeno
#  #================
#  #Make sure you ran downloadSambada() before running this command.
#  prepareGeno(fileName=genoFile,outputFile=file.path(tempdir(),'uganda-subset-mol.csv'),saveGDS=TRUE,mafThresh=0.05, missingnessThresh=0.1,interactiveChecks=FALSE) #Also try with interactiveChecks=TRUE

## ---- eval=FALSE--------------------------------------------------------------
#  #Locate file containing only IDs of individuals
#  #================
#  idFile=system.file("extdata", "uganda-subset-id.csv", package = "R.SamBada")
#  idFile #Check the path to the file
#  
#  #Load help
#  #================
#  ?setLocation
#  
#  #Run setLocation
#  #================
#  setLocation()
#  #Once the browser opens, you can load the file uganda-subset-id.csv mentioned above

## ---- eval=FALSE--------------------------------------------------------------
#  #Loads data
#  #================
#  #These files are distributed within your package. The system.file will return the full path to them. With your data, you can just use the name of the file, provided the file is in the active directory
#  locationFile=system.file("extdata", "uganda-subset.csv", package = "R.SamBada")
#  readLines(locationFile, n=20) #View the first 20 lines of the input file
#  
#  #Load help
#  #================
#  ?createEnv
#  
#  #Create environmental dataset
#  #================
#  #downloads the raster tiles from global databases and create the environmental file
#  #Warning: the download and processing of raster is both heavy in space and time-consuming
#  #If you want to save time, you can skip this step continue to the next function
#  createEnv(locationFileName=locationFile, outputFile=file.path(tempdir(),'uganda-subset-env.csv'), x='longitude',y='latitude',locationProj=4326,separator=';', worldclim=TRUE, saveDownload=TRUE, rasterName=NULL,rasterProj=NULL, interactiveChecks=FALSE) #Also try with interactiveChecks=TRUE

## ---- eval=FALSE--------------------------------------------------------------
#  #Loads data
#  #================
#  #Locate gds file. Note: this file has also been generated from prepareGeno
#  #GDS files are binary files that are system dependent
#  if(Sys.info()['sysname']=='Windows'){
#    gdsFile=system.file("extdata", "uganda-subset-mol_windows.gds", package = "R.SamBada") #If you run Windows
#  }else{
#    gdsFile=system.file("extdata", "uganda-subset-mol_unix.gds", package = "R.SamBada") #If you run MacOS or Linux
#  }
#  gdsFile #Check the path to the file
#  
#  #Locate the envFile (generated from createEnv)
#  envFile=system.file("extdata", "uganda-subset-env.csv", package = "R.SamBada")
#  readLines(envFile, n=20) #View the first 20 lines of the file
#  
#  #Load help
#  #================
#  ?prepareEnv
#  
#  #prepareEnv
#  #================
#  
#  #Stores Principal components scores
#  prepareEnv(envFile=envFile, outputFile=file.path(tempdir(),'uganda-subset-env-export.csv'), maxCorr=0.8, idName='short_name', genoFile=gdsFile, numPc=0.2, mafThresh=0.05, missingnessThresh=0.1, ldThresh=0.2, numPop=NULL, x='longitude', y='latitude', interactiveChecks=FALSE, locationProj=4326 )
#  #Also try with interactiveChecks=TRUE

## ---- eval=FALSE--------------------------------------------------------------
#  #Loads data
#  #================
#  #Locate envFile (created with preapreEnv)
#  envFile2=system.file("extdata", "uganda-subset-env-export.csv", package = "R.SamBada")
#  readLines(envFile2, n=20) #View the first 20 line of the environmental file
#  
#  #Locate genoFile in csv format (created with prepareGeno)
#  genoFile2=system.file("extdata", "uganda-subset-mol.csv", package = "R.SamBada")
#  readLines(genoFile2, n=20) #View the first 20 line of the genetic file
#  
#  #Load help
#  #================
#  ?sambadaParallel
#  
#  #sambadaParallel
#  #================
#  #Run sambada on two cores.
#  #Make sure you ran downloadSambada() before running this command.
#  #Only one pop var was saved, so set dimMax=2. prepareEnv puts the population variables at the end of the file (=> LAST).
#  sambadaParallel(genoFile=genoFile2, envFile=envFile2, idGeno='ID_indiv', idEnv='short_name', dimMax=2, cores=2, saveType='END ALL', populationVar='LAST', outputFile=file.path(tempdir(),'uganda-subset-mol'))
#  

## ---- eval=FALSE--------------------------------------------------------------
#  #Loads data
#  #================
#  #You first need to copy the output file of sambadaParallel and prepareGeno into the active directory with the following command
#  file.copy(system.file("extdata", "uganda-subset-mol-Out-2.csv", package = "R.SamBada"), 'uganda-subset-mol-Out-2.csv')
#  file.copy(system.file("extdata", "uganda-subset-mol-storey.csv", package = "R.SamBada"), 'uganda-subset-mol-storey.csv')
#  
#  #Copy GDS file (generated from prepareGeno)
#  if(Sys.info()['sysname']=='Windows'){
#    file.copy(system.file("extdata", "uganda-subset-mol_windows.gds", package = "R.SamBada"),'uganda-subset-mol.gds') #If you run Windows
#  } else {
#    file.copy(system.file("extdata", "uganda-subset-mol_unix.gds", package = "R.SamBada"),'uganda-subset-mol.gds') #If you run MacOS or Linux
#  }
#  
#  
#  #Load help
#  #================
#  ?prepareOutput
#  
#  #prepareOutput
#  #================
#  prep = prepareOutput(sambadaname='uganda-subset-mol', dimMax=2, popStr=TRUE, interactiveChecks=FALSE)
#  #Also try with interactiveChecks=TRUE
#  

## ---- eval=FALSE--------------------------------------------------------------
#  #Loads data
#  #================
#  #You need to run prepareOutput to run this function
#  
#  #Load help
#  #================
#  ?plotManhattan
#  
#  #plotManhattan
#  #================
#  #Plot manhattan of all kept variables
#  plotManhattan(prep, c('bio1','bio2','bio3'),chromo='all',valueName='pvalueG')
#  #Warning: the manhattan plot is different from what we are used to see, given the small number of SNPs
#  

## ---- eval=FALSE--------------------------------------------------------------
#  #Loads data
#  #================
#  #You need to run prepareOutput to run this function
#  #Locate environmantal file (generated with prepareEnv)
#  envFile2=system.file("extdata", "uganda-subset-env-export.csv", package = "R.SamBada")
#  
#  #Locate GDS file (generated from prepareGeno)
#  if(Sys.info()['sysname']=='Windows'){
#    gdsFile=system.file("extdata", "uganda-subset-mol_windows.gds", package = "R.SamBada") #If you run Windows
#  }else {
#    gdsFile=system.file("extdata", "uganda-subset-mol_unix.gds", package = "R.SamBada") #If you run MacOS or Linux
#  }
#  
#  #Load help
#  #================
#  ?plotResultInteractive
#  
#  #plotResultInteractive
#  #================
#  
#  plotResultInteractive(preparedOutput=prep, varEnv='bio1', envFile=envFile2,species='btaurus', pass=50000,x='longitude',y='latitude',gdsFile=gdsFile, IDCol='short_name', popStrCol='pop1')
#  #Accepts the Dataset and SNP Data found
#  #Once the interactive window opens, click on any point of the manhattan plot

## ---- eval=FALSE--------------------------------------------------------------
#  #Loads data
#  #================
#  #You need to run prepareOutput to run this function
#  #Locate environmental file (generated with prepareEnv)
#  envFile2=system.file("extdata", "uganda-subset-env-export.csv", package = "R.SamBada")
#  
#  #Locate GDS file (generated from prepareGeno)
#  if(Sys.info()['sysname']=='Windows'){
#    gdsFile=system.file("extdata", "uganda-subset-mol_windows.gds", package = "R.SamBada") #If you run Windows
#  }else {
#    gdsFile=system.file("extdata", "uganda-subset-mol_unix.gds", package = "R.SamBada") #If you run MacOS or Linux
#  }
#  
#  #Load help
#  #================
#  ?plotMap
#  
#  #plotMap
#  #================
#  
#  plotMap(envFile=envFile2, x='longitude', y='latitude', locationProj=4326,  popStrCol='pop1', gdsFile=gdsFile, markerName='Hapmap28985-BTA-73836_GG', mapType='marker', varEnvName='bio1', simultaneous=FALSE)
#  

