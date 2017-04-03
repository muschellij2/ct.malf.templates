#' @title Get Image Filenames for templates
#'
#' @description Return a list of filenames for the images
#'
#' @return List of filenames
#'
#' @export
ct_malf_images = function(){


  ids = sprintf("%02.0f", 1:35)

  fnames = paste0(ids, ".nii.gz")
  # labels = paste0(ids, "_mask.nii.gz")
  # ss = paste0(ids, "_SS.nii.gz")
  masks = paste0(ids, "_mask.nii.gz")

  L = list(images = fnames,
           # labels = labels,
           # brains = ss,
           masks = masks)
  L = lapply(L, function(x) {
    fnames = system.file( "extdata", x,
                        package = "ct.malf.templates")
  })
  return(L)
}

#' @rdname ct_malf_images
#' @param ... arguments to pass \code{\link{ct_malf_images}}
#' @export
ct_malf_template_images = function(...) {
  L = ct_malf_images(...)
  return(L$images)
}



#' @rdname ct_malf_images
#' @export
ct_malf_template_masks = function(...) {
  L = ct_malf_images(...)
  return(L$masks)
}


#' #' @rdname ct_malf_images
#' #' @export
#' ct_malf_template_labels = function(...) {
#'   L = ct_malf_images(...)
#'   return(L$labels)
#' }
#'
#' #' @rdname ct_malf_images
#' #' @export
#' ct_malf_template_brains = function(...) {
#'   L = ct_malf_images(...)
#'   return(L$brains)
#' }
