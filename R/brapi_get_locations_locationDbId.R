#' @title
#' get /locations/\{locationDbId\}
#'
#' @description
#' Get the details of a specific Location
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param locationDbId character; required: TRUE; The internal DB id for a location
#'
#' @details Get details for a location.
#' * The `countryCode` is as per [ISO_3166-1_alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) spec.
#' * coordinates are specified as longitude, latitude (in this specific order).
#' * `altitude` (optional third parameter to coordinates) is in meters.
#'
#' @return data.frame
#'
#' @author Maikel Verouden
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI-Core/2.0#/Locations/get_locations__locationDbId_}{BrAPI SwaggerHub}
#'
#' @family brapi-core
#' @family Locations
#'
#' @examples
#' \dontrun{
#' con <- brapi_db()$testserver
#' brapi_get_locations_locationDbId(con = con, locationDbId = "location_01")
#' }
#'
#' @export
brapi_get_locations_locationDbId <- function(con = NULL, locationDbId = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "locationDbId")
  ## Obtain the call url
  callurl <- brapi_GET_callURL(usedArgs = usedArgs,
                               callPath = "/locations/{locationDbId}",
                               reqArgs = "locationDbId",
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
  class(out) <- c(class(out), "brapi_get_locations_locationDbId")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(resp_cont)
  return(out)
}
