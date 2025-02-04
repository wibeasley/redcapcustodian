% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/unnest_job_summary_data_json_object.R
\name{unnest_job_summary_data_json_object}
\alias{unnest_job_summary_data_json_object}
\title{unnest_job_summary_data_json_object}
\usage{
unnest_job_summary_data_json_object(log_data)
}
\arguments{
\item{log_data}{- a dataframe of job summary logs}
}
\value{
- the input dataframe of job summary logs with `job_summary_data`
  replaced by the R objects that were JSON-encoded therein.
}
\description{
The REDCap Custodian logging provide a field, `job_summary_data`, to store
arbitrary details about a job. Its contents are defined entirely by the script,
but in practice, it is very easy to encode a data frame or a list of data
frames into a JSON object, so this has become the common practice.

Yet using the data can be a bit more complex because `jsonlite::fromJSON` is
not vectorized. If you need read multiple job log records, iteration is
required to use JSON object in `job_summary_data`.

This function addresses that need accepting a dataframe of job summary logs
and unnesting the JSON object(s) in `job_summary_data` into the equivalent R objects.
}
\examples{
\dontrun{
library(redcapcustodian)
library(RMariaDB)
library(DBI)
library(tidyverse)
library(dotenv)

init_etl("pbc_scratch")

log_conn <- get_package_scope_var("log_con")

log_data <- tbl(log_conn, "rcc_job_log") \%>\%
  dplyr::filter(script_name == "warn_owners_of_impending_bill") \%>\%
  collect()

unnest_job_summary_data_json_object(log_data)
}
}
