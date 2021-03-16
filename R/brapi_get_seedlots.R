#' @title
#' get /seedlots
#'
#' @description
#' Get a filtered list of Seed Lot descriptions available in a system.
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param seedLotDbId character; required: FALSE; Unique id for a seed lot on this server
#' @param germplasmDbId character; required: FALSE; The internal id of the germplasm
#' @param externalReferenceID character; required: FALSE; An external reference ID. Could be a simple string or a URI. (use with externalReferenceSource parameter)
#' @param externalReferenceSource character; required: FALSE; An identifier for the source system or database of an external reference (use with `externalReferenceID` parameter)
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Get the list of germplasm breeding methods available in a system.
#'
#' @return data.frame
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI-Germplasm/2.0#/Germplasm/get_breedingmethods}{BrAPI SwaggerHub}
#'
#' @family BrAPI-Germplasm
#' @family Seed Lots
#'
#' @export
brapi_get_seedlots <- function(con = NULL, page = 0, seedLotDbId = '', germplasmDbId = '', externalReferenceID = '', externalReferenceSource = '', pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/seedlots",
                               reqArgs = "",
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
  class(out) <- c(class(out), "brapi_get_seedlots")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(resp_cont)
  return(out)
}
