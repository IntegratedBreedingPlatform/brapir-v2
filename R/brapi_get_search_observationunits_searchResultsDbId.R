#' @title
#' GET /search/observationunits/{searchResultsDbId}
#'
#' @description
#' Submit a search request for Observation Units
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param searchResultsDbId; required: TRUE; Unique identifier which references the search results
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Returns a list of observationUnit with the observed Phenotypes.
#' See Search Services for additional implementation details.
#'
#' @return data.frame
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI-Phenotyping/2.0#/Observation%20Units/get_search_observationunits__searchResultsDbId_}{BrAPI SwaggerHub}
#'
#' @family BrAPI-Phenotyping
#' @family Observation Units
#'
#' @export
brapi_get_search_observationunits_searchResultsDbId <- function(con = NULL, searchResultsDbId = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "searchResultsDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                                callPath = "/search/observationunits/{searchResultsDbId}",
                                reqArgs = "searchResultsDbId",
                                packageName = "BrAPI",
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
  class(out) <- c(class(out), "brapi_get_search_observationunits_searchResultsDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(resp_cont)
  return(out)
}
