% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ct_mass_images.R
\name{ct_mass_images}
\alias{ct_mass_images}
\alias{ct_mass_template_images}
\alias{ct_mass_template_masks}
\title{Get Image Filenames for Skull Stripping}
\usage{
ct_mass_images(n_templates = 35)

ct_mass_template_images(...)

ct_mass_template_masks(...)
}
\arguments{
\item{n_templates}{Number of template filenames to return}

\item{...}{arguments to pass \code{\link{ct_mass_images}}}
}
\value{
List of filenames for images and masks
}
\description{
Return a list of filenames for the images and
brain masks
}
