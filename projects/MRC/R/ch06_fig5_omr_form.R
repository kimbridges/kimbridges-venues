# ch06_fig5_omr_form.R -- MRC chapter 6: Kim's University of Hawaiʻi OMR service request form (BIOL101).
# Renders the kept PDF and covers the e-mail address and telephone number (Kim's ruling, 2026-11-03).
library(magick)
f <- 'G:/My Drive/Projects/MRC/sources/ITS_OMR_service_request_BIOL101.pdf'
im <- image_read_pdf(f, density = 200)[1]
d <- image_draw(im)
rect(1548, 203, 2085, 258, col = '#E6E6E6', border = NA)   # e-mail address
rect(1580, 280, 2085, 334, col = '#E6E6E6', border = NA)   # telephone number
dev.off()
d <- image_border(image_background(d, 'white'), 'grey60', '3x3')
image_write(d, 'G:/My Drive/Projects/MRC/figures/ch06_fig5_omr_form.png', format = 'png', density = 200)
cat('written\n')
