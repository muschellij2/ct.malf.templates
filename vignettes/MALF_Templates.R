## ---- message = TRUE-----------------------------------------------------
library(ct.malf.templates)

## ------------------------------------------------------------------------
mi = ct_malf_images()
names(mi)

## ------------------------------------------------------------------------
mi = ct_mass_images()
names(mi)
head(ct_mass_template_images())
head(ct_mass_template_masks())

