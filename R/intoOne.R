#' intoOne Function
#'
#' This function is some very simple code that put all the datafiles in one dataset.
#'
#' @param path A string for the path of dataset file.
#' @param name A string for the name of questionnaire.
#' @keywords pre-analysis
#' @export
#' @examples
#'  \dontrun{
#'     BBSIQ <- intoOne('BBSIQ','~/active_data/')
#'    }
#'  \dontrun{
#'     intoOne('All','~/active_data/')
#'    }
#' @return An object with both raw and scored data.


intoOne <- function(name, path) {
  library(gdata)
  clip <- function(N,path) {
    setwd(path)
    file_list <- list.files()
    target_list <- file_list[startsWith(file_list,N,trim=TRUE,ignore.case=TRUE)]
    for (file in target_list){
      # if the merged dataset doesn't exist, create it
      if (!exists("intoOne_dataset")){
        intoOne_dataset <- read.csv(file, header=TRUE)
      }
      # if the merged dataset does exist, append to it
      if (exists("dataset")){
        temp_dataset <-read.csv(file, header=TRUE)
        intoOne_dataset<-rbind(intoOne_dataset, temp_dataset)
        rm(temp_dataset)
      }
      dataFile <- paste(path,'/',N,'_Master_',Sys.time(),'.csv', sep="")
      write.csv(intoOne_dataset,file = dataFile, col.names = F, row.names = F)
      answer <- intoOne_dataset
      rm(intoOne_dataset)
      return(answer)
    }
  }
  if (name == 'All') {
    library(jsonlite)
    benchMarkFile <- paste(path,,'/benchMark.json',sep="")
    quest_list <- names(fromJSON(benchMarkFile))
    sapply(quest_list,clip,var2 = path)
    return("All are done!")
  }
  else {
    return(clip(name,path))
  }
}
