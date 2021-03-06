% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/unpublish_dataset.R
\name{unpublish_dataset}
\alias{unpublish_dataset}
\title{unpublish_dataset}
\usage{
unpublish_dataset(
  nid,
  root_url = dkanr::get_url(),
  credentials = list(cookie = dkanr::get_cookie(), token = dkanr::get_token())
)
}
\arguments{
\item{nid}{character: Node ID of the dataset to be unpublished}

\item{root_url}{character: API root URL}

\item{credentials}{list: DDH API authentication token and cookie}
}
\value{
list
}
\description{
Unpublish existing dataset in DDH
}
