#' @title
#' get /programs
#'
#' @description
#' Get filtered list of breeding Programs
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param commonCropName character; required: FALSE; Filter by the common crop name. Exact match.
#' @param programDbId character; required: FALSE; Filter by programDbId. Exact match.
#' @param programName character; required: FALSE; Filter by program name. Exact match.
#' @param abbreviation character; required: FALSE; Filter by abbreviation name. Exact match.
#' @param externalReferenceID character; required: FALSE; An external reference ID. Could be a simple string or a URI. (use with `externalReferenceSource` parameter)
#' @param externalReferenceSource character; required: FALSE; An identifier for the source system or database of an external reference (use with `externalReferenceID` parameter)
#' @param page integer; required: FALSE; Used to request a specific page of data to be returned. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Get filtered list of breeding Programs.
#'
#' @return data.frame
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI-Core/2.0#/Programs/get_programs}{BrAPI SwaggerHub}
#'
#' @family brapi-core
#' @family Programs
#'
#' @examples
#' \dontrun{
#' con <- brapi_db()$testserver
#' brapi_get_programs(con = con)
#' }
#'
#' @export
brapi_get_programs <- function(con = NULL, commonCropName = '', programDbId = '', programName = '', abbreviation = '', externalReferenceID = '', externalReferenceSource = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/programs",
                               reqArgs = "",
                               packageName = "BrAPI-Core",
                               isCropDbSpecific = T, # in case of a multicrop server, brapi_GET_callURL() defaults to "/{cropDb}/brapi/v2/programs". "isCropDbSpecific = T" yields "/brapi/v2/programs"
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
  class(out) <- c(class(out), "brapi_get_programs")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(resp_cont)
  return(out)
}
