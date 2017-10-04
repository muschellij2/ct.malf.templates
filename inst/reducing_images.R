#####################
#
#####################
rm(list = ls())
library(neurobase)
library(extrantsr)
library(ANTsR)
# ids = c(2:3, 5, 10)
ids = list.files(pattern = "_mask")
ids = gsub("(\\d\\d).*", "\\1", ids)
# ids = sprintf("%02.0f", ids)

df = data.frame(id = ids,
                img = paste0(ids, ".nii.gz"),
                mask = paste0(ids, "_mask.nii.gz"),
                stringsAsFactors = FALSE)
df$res_brain = file.path("extdata", df$img)
df$res_mask = file.path("extdata", df$mask)

iid = 1

iid = as.numeric(Sys.getenv("SGE_TASK_ID"))
if (is.na(iid)) {
  iid = 2
}

# for (iid in seq(nrow(df))) {
  print(iid)
  img_fname = df$img[iid]
  mask_fname = df$mask[iid]
  brain_outfile = df$res_brain[iid]
  mask_outfile = df$res_mask[iid]

  if (!all(file.exists(brain_outfile,
                       mask_outfile))) {
    # img = readnii(img_fname)
    # img_mask = img > -300
    img = antsImageRead(img_fname)
    img_mask = as.antsImage(img > -300, 
      reference = img)
    cc = iMath(img_mask, "GetLargestComponent", 
      retfile = TRUE)

    filled = filler(cc, fill_size = 11)
    rm(list = "cc"); gc(); gc(); gc(); gc();
    
    # mask = readnii(mask_fname)
    mask = antsImageRead(mask_fname)
    stopifnot(all(unique(mask[filled == 0]) == 0))
    img[ filled == 0] = -1024
    
    # mask = filler(mask, fill_size = 2)
    message("filling holes")
    mask = oMath(mask, "FillHoles", retfile = TRUE)
    message("dropping dimensions")
    
    gg = getEmptyImageDimensions(as.array(filled))
    dd = list(img = as.array(img),
      mask = as.array(mask))
    dd = lapply(dd, applyEmptyImageDimensions,
      inds = gg)
    dd = mapply(function(img, reference){
      as.antsImage(img, reference = reference)
    }, dd, list(img, mask), SIMPLIFY = FALSE)
    # dd = dropEmptyImageDimensions(filled,
    #     other.imgs = list(img = img,
    #                       mask = mask))
    # dd = dd$other.imgs

    res_brain = dd$img
    res_mask = dd$mask
    rm(list = c("dd", "filled")); gc(); gc(); 
    for (i in 1:10) gc();
    
    write_nifti(res_brain, filename = brain_outfile)
    write_nifti(res_mask, filename = mask_outfile)
    rm(list = c("img", "mask")); gc(); gc();
    
  }
# }
