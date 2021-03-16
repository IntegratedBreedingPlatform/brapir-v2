#' @title
#' POST /search/observationunits
#'
#' @description
#' Submit a search request for Observation Units
#'
#' @param con list; required: TRUE; BrAPI connection object
#' @param programDbIds vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param programNames vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param trialDbIds vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param trialNames vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param studyDbIds vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param studyNames vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param locationDbIds vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param locationNames vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param germplasmDbIds vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param germplasmNames vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param observationVariableDbIds vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param observationVariableNames vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param externalReferenceIDs vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#' @param externalReferenceSources vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)#' @param page integer; required: FALSE; Which result page is requested. The page indexing starts at 0 (the first page is 'page'= 0). Default is `0`.
#' @param includeObservations boolean; required: FALSE; default: FALSE
#' @param observationLevelRelationships list; required: FALSE;
#' @param observationLevels list; required: FALSE;
#' @param observationUnitDbIds vector of type character; required: FALSE; default: &quot;&quot;, when using multiple values supply as c(&quot;value1&quot;, &quot;value2&quot;)
#'
#' @param pageSize integer; required: FALSE; The size of the pages to be returned. Default is `1000`.
#'
#' @details Returns a list of observationUnit with the observed Phenotypes.
#' See Search Services for additional implementation details.
#'
#' Use case - this section allows to get a dataset from multiple studies. It allows to integrate data from several databases.
#'
#' Example Use cases:
#' - Study a panel of germplasm across multiple studies
#' - Get all data for a specific study
#' - Get simple atomic phenotyping values
#' - Study Locations for adaptation to climate change
#' - Find phenotypes that are from after a certain timestamp
#'
#' observationTimeStampRangeStart and observationTimeStampRangeEnd use Iso Standard 8601.
#'
#' observationValue data type inferred from the ontology
#'
#' @return data.frame
#'
#' @references \href{https://app.swaggerhub.com/apis/PlantBreedingAPI/BrAPI-Phenotyping/2.0#/Observation%20Units/post_search_observationunits}{BrAPI SwaggerHub}
#'
#' @family BrAPI-Phenotyping
#' @family Observation Units
#'
#' @export
brapi_post_search_observationunits <- function(con = NULL, programDbIds = '', programNames = '', trialDbIds = '', trialNames = '', studyDbIds = '', studyNames = '', locationDbIds = '', locationNames = '', germplasmDbIds = '', germplasmNames = '', observationVariableDbIds = '', observationVariableNames = '', externalReferenceIDs = '', externalReferenceSources = '', includeObservations = FALSE, observationLevelRelationships = '', observationLevels = '', observationUnitDbIds = '') {
  ## Create a list of used arguments
  usedArgs <- brapi_usedArgs(origValues = FALSE)
  ## Check if BrAPI server can be reached given the connection details
  brapi_checkCon(con = usedArgs[["con"]], verbose = FALSE)
  ## Check validity of used and required arguments
  brapi_checkArgs(usedArgs, reqArgs = "")
  ## Obtain the call url
  callurl <- brapi_POST_callURL(usedArgs = usedArgs,
                               callPath = "/search/observationunits",
                               reqArgs = "",
                               packageName = "BrAPI",
                               callVersion = 2.0)
  ## Build the Body
  callbody <- brapi_POST_callBody(usedArgs = usedArgs,
                                  reqArgs = "")
  try({
    ## Make the call and receive the response
    resp <- brapi_POST(url = callurl, body = callbody, usedArgs = usedArgs)
    ## Extract the content from the response object in human readable form
    resp_cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    ## Convert the content object into a data.frame
    out <- brapi_result2df(resp_cont, usedArgs)
  })
  ## Set class of output
  class(out) <- c(class(out), "brapi_post_search_observationunits")
  ## Show pagination information from metadata
  brapi_serverinfo_metadata(resp_cont)
  return(out)
}
