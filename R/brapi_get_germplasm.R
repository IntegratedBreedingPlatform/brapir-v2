#' @title
#' GET /germplasm
#'
#' @description
#' Get a filtered list of Germplasm
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param germplasmPUI character; required: FALSE; Permanent unique identifier (DOI, URI, etc.)
#' @param germplasmDbId character; required: FALSE; Internal database identifier
#' @param germplasmName character; required: FALSE; Name of the germplasm
#' @param commonCropName character; required: FALSE; The common crop name related to this germplasm
#' @param accessionNumber character; required: FALSE; Unique identifiers for accessions within a genebank
#' @param collection character; required: FALSE; A specific panel/collection/population name this germplasm belongs to
#' @param genus character; required: FALSE; Genus name to identify germplasm
#' @param species character; required: FALSE; Species name to identify germplasm
#' @param studyDbId character; required: FALSE; Search for Germplasm that are associated with a particular Study
#' @param synonym character; required: FALSE; Alternative name or ID used to reference this germplasm
#' @param parentDbId character; required: FALSE; Search for Germplasm with this parent
#' @param progenyDbId character; required: FALSE; Search for Germplasm with this child
#' @param externalReferenceID character; required: FALSE; An external reference ID. Could be a simple string or a URI. (use with externalReferenceSource parameter)
#' @param externalReferenceSource character; required: FALSE; An identifier for the source system or database of an external reference (use with `externalReferenceID` parameter)
#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Addresses these needs
#' - General germplasm search mechanism that accepts POST for complex queries
#' - Possibility to search germplasm by more parameters than those allowed by the existing germplasm search
#' - Possibility to get MCPD details by PUID rather than dbId
#'
#' @return data.frame
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI/2.0#/Germplasm/get_germplasm }{BrAPI SwaggerHub}
#'
#' @family BrAPI-Germplasm
#' @family Germplasm
#'
#' @export
brapi_get_germplasm <- function(con = NULL, germplasmPUI = '', germplasmDbId = '', germplasmName = '', commonCropName = '', accessionNumber = '', collection = '', genus = '', species = '', studyDbId = '', synonym = '', parentDbId = '', progenyDbId = '', externalReferenceID = '', externalReferenceSource = '', page = 0, pageSize = 1000) {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/germplasm",
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
  class(out) <- c(class(out), "brapi_get_germplasm")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(resp_cont)
  return(out)
}
