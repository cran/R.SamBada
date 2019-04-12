## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=FALSE---------------------------------------------------------
#  #Load help
#  ?downloadSambada()
#  #Downloads Sambada into the temporary directory
#  downloadSambada(tempdir()) #remove tempdir() to downlaod it in the current directory.

## ---- eval=FALSE---------------------------------------------------------
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
#  #Warning: the histograms shown due to maf and missingness filtering are really difficult to understand given the small number of SNPs
#  prepareGeno(fileName=genoFile,outputFile=file.path(tempdir(),'uganda-subset-mol.csv'),saveGDS=TRUE,mafThresh=0.05, missingnessThresh=0.1,interactiveChecks=TRUE)
#  #remove tempdir(), to save the file to your current directory

## ---- eval=FALSE---------------------------------------------------------
#  #Load help
#  #================
#  ?setLocation
#  
#  #Run setLocation
#  #================
#  setLocation()
#  #Once the browser opens, you can load the file uganda-subset-id.csv located in extdata folder of the package

## ---- eval=FALSE---------------------------------------------------------
#  #Loads data
#  #================
#  #These files are distributed within your package. The system.file will return the full path to them. With your data, you can just use the name of the file, provided the file is in the active directory
#  locationFile=system.file("extdata", "uganda-subset.csv", package = "R.SamBada")
#  locationFile #Check the path to the file
#  
#  #Load help
#  #================
#  ?createEnv
#  
#  #Create environmental dataset
#  #================
#  #downloads the raster tiles from global databases and create the environmental file
#  #Warning: the download and processing of raster is both heavy in space and time-consuming
#  #If you want to skip this step, you can skip this step and continue to the next function
#  createEnv(locationFileName=locationFile, outputFile='uganda-subset-env.csv', x='longitude',y='latitude',locationProj=4326,separator=';', worldclim=TRUE, saveDownload=TRUE, rasterName=NULL,rasterProj=NULL, interactiveChecks=TRUE)
#  

## ---- eval=FALSE---------------------------------------------------------
#  #Loads data
#  #================
#  #If you ran prepareGeno, use the gds file created in this step
#  gdsFile='uganda-subset-mol.gds'
#  #Otherwise, take the one prvided in the package
#  gdsFile=system.file("extdata", "uganda-subset-mol_windows.gds", package = "R.SamBada") #If you run Windows
#  gdsFile=system.file("extdata", "uganda-subset-mol_unix.gds", package = "R.SamBada") #If you run MacOS or Linux
#  gdsFile #Check the path to the file
#  #If you ran createEnv, use the .csv file created in this step
#  envFile='uganda-subset-env.csv'
#  #Otherwise, take the one prvided in the package
#  envFile=system.file("extdata", "uganda-subset-env.csv", package = "R.SamBada")
#  envFile #Check the path to the file
#  
#  #Load help
#  #================
#  ?prepareEnv
#  
#  #prepareEnv
#  #================
#  
#  #Stores Principal components scores
#  prepareEnv(envFile=envFile, outputFile=file.path(tempdir(),'uganda-subset-env-export.csv'), maxCorr=0.8, idName='short_name', genoFile=gdsFile, numPc=0.2, mafThresh=0.05, missingnessThresh=0.1, ldThresh=0.2, numPop=NULL, x='longitude', y='latitude', interactiveChecks=TRUE, locationProj=4326 )
#  #Accept the maxCorr threshold, and numPc to 1.
#  #remove "tempdir()," to save to the current directory

## ---- eval=FALSE---------------------------------------------------------
#  #Loads data
#  #================
#  #If you ran prepareEnv, use the .csv file created in this step
#  envFile='uganda-subset-env-export.csv'
#  #Otherwise, take the one prvided in the package
#  envFile=system.file("extdata", "uganda-subset-env-export.csv", package = "R.SamBada")
#  envFile #Check the path to the file
#  #If you ran prepareGeno, use the .csv file created in this step
#  genoFile='uganda-subset-mol.csv'
#  #Otherwise, take the one prvided in the package
#  genoFile=system.file("extdata", "uganda-subset-mol.csv", package = "R.SamBada")
#  genoFile #Check the path to the file
#  
#  #Load help
#  #================
#  ?sambadaParallel
#  
#  #sambadaParallel
#  #================
#  #Run sambada on two cores.
#  #prepareEnv puts the population variables at the end of the file (=> LAST).
#  #Only one pop var was saved, so set dimMax=2
#  sambadaParallel(genoFile=genoFile, envFile=envFile, idGeno='ID_indiv', idEnv='short_name', dimMax=2, cores=2, saveType='END ALL', populationVar='LAST', outputFile=file.path(tempdir(),'uganda-subset-mol'))
#  

## ---- eval=FALSE---------------------------------------------------------
#  #Loads data
#  #================
#  #If you haven't run sambadaParallel, you need to copy the output file into the active directory with the following command
#  file.copy(system.file("extdata", "uganda-subset-mol-Out-2.csv", package = "R.SamBada"), 'uganda-subset-mol-Out-2.csv')
#  file.copy(system.file("extdata", "uganda-subset-mol-storey.csv", package = "R.SamBada"), 'uganda-subset-mol-storey.csv')
#  #Furthermore, if you haven't run prepareGeno, you need to copy the GDS file with the following command
#  file.copy(system.file("extdata", "uganda-subset-mol_windows.gds", package = "R.SamBada"),'uganda-subset-mol.gds') #If you run Windows
#  file.copy(system.file("extdata", "uganda-subset-mol_unix.gds", package = "R.SamBada"),'uganda-subset-mol.gds') #If you run MacOS or Linux
#  
#  
#  #Load help
#  #================
#  ?prepareOutput
#  
#  #prepareOutput
#  #================
#  prep = prepareOutput(sambadaname='uganda-subset-mol', dimMax=2, popStr=TRUE, interactiveChecks=TRUE)
#  #Accepts both pi0 parameter for G and Wald score
#  

## ---- eval=FALSE---------------------------------------------------------
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

## ---- eval=FALSE---------------------------------------------------------
#  #Loads data
#  #================
#  #You need to run prepareOutput to run this function
#  #If you haven't run prepareEnv, use the file provided in the package
#  envFile=system.file("extdata", "uganda-subset-env-export.csv", package = "R.SamBada")
#  #Otherwise use
#  envFile='uganda-subset-env-export.csv'
#  #If you haven't run prepareGeno, use the file provided in the package
#  gdsFile=system.file("extdata", "uganda-subset-mol_windows.gds", package = "R.SamBada") #If you run Windows
#  gdsFile=system.file("extdata", "uganda-subset-mol_unix.gds", package = "R.SamBada") #If you run MacOS or Linux
#  #Otherwise use
#  gdsFile='uganda-subset-mol.gds'
#  
#  #Load help
#  #================
#  ?plotResultInteractive
#  
#  #plotResultInteractive
#  #================
#  
#  plotResultInteractive(preparedOutput=prep, varEnv='bio1', envFile=envFile,species='btaurus', pass=50000,x='longitude',y='latitude',gdsFile=gdsFile, IDCol='short_name', popStrCol='pop1')
#  #Accepts the Dataset and SNO Data found
#  #Once the interactive window opens, click on any point of the manhattan plot

## ---- eval=FALSE---------------------------------------------------------
#  #Loads data
#  #================
#  #You need to run prepareOutput to run this function
#  #If you haven't run prepareEnv, use the file provided in the package
#  envFile=system.file("extdata", "uganda-subset-env-export.csv", package = "R.SamBada")
#  #Otherwise use
#  envFile='uganda-subset-env-export.csv'
#  #If you haven't run prepareGeno, use the file provided in the package
#  gdsFile=system.file("extdata", "uganda-subset-mol_windows.gds", package = "R.SamBada") #If you run Windows
#  gdsFile=system.file("extdata", "uganda-subset-mol_unix.gds", package = "R.SamBada") #If you run MacOS or Linux
#  #Otherwise use
#  gdsFile='uganda-subset-mol.gds'
#  
#  #Load help
#  #================
#  ?plotMap
#  
#  #plotMap
#  #================
#  
#  plotMap(envFile=envFile, x='longitude', y='latitude', locationProj=4326,  popStrCol='pop1', gdsFile=gdsFile, markerName='Hapmap28985-BTA-73836_GG', mapType='marker', varEnvName='bio1', simultaneous=FALSE)
#  

