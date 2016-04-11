#' take Function
#'
#' Import the dataset file, attribute the class of the dataset, and then score it.
#'
#' The function is used to read and score dataset.
#' @param path A string for the path of dataset file.
#' @param type A variable indicating the data stage, default to be raw data.
#' @param multiple A Boolean variable indicating whether this questionnaire has been used in multiple sessions.
#' @keywords read import
#' @export
#' @examples
#'  \dontrun{
#'      BBSIQ <- take("BBSIQ.csv","BBSIQ",TRUE)
#'    }
#' @return An object with both raw and scored data.

take <- function(path, type, multiple = FALSE) {
  data <- list()
  class(data) <- type
  data$raw <- read.csv(path)
  data$scored <- score(data)
  return(data)
}
