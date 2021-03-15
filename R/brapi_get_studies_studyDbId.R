#' @title
#' get /studies/{studyDbId}
#'
#' @description
#' Get the detail of a specific study
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param studyDbId character; required: FALSE; Filter by studyDbId
#'
#' @return data.frame
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI-Core/2.0#/Studies/get_studies__studyDbId_}{BrAPI SwaggerHub}
#'
#' @family brapi-core
#' @family Studies
#'
#' @examples
#' \dontrun{
#' con <- brapi_db()$testserver
#' brapi_get_studies_studyDbId(con = con)
#' }
#'
#' @export
brapi_get_studies_studyDbId <- function(con = NULL, studyDbId = "") {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/studies/{studyDbId}",
                               reqArgs = "",
                               packageName = "BrAPI-Core",
                               callVersion = 2.0)

  try({
    ## Make the call and receive the response
    resp <- brapi_GET(url = callurl, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    resp_cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(resp_cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_get_studies_studyDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(resp_cont)
  return(out)
}
