# where_is_500hpa.R -- making "500 hPa" relatable: altitude, landmarks, and the share of air below.
# Kim + Claude, 2026-11-25. Standard-atmosphere heights (troposphere formula); landmark heights in m.
library(ggplot2)
p_of_z <- function(z) 1013.25 * (1 - 2.25577e-5 * z)^5.25588              # m -> hPa
z_of_p <- function(p) (1 - (p / 1013.25)^(1 / 5.25588)) / 2.25577e-5        # hPa -> m
# Results (2026-11-25): 850 hPa 1,457 m (16% of air below); 500 hPa 5,574 m (51%); 250 hPa 10,363 m (75%).
# Haleakala 3,055 m ~ 696 hPa; Mauna Kea 4,207 m ~ 600 hPa (41% below); Kilimanjaro 5,895 m ~ 479 hPa;
# Denali 6,190 m ~ 460 hPa; Everest 8,849 m ~ 314 hPa (69% below). Airliner cruise 35,000 ft ~ 10.7 km.
# Today's 500 hPa surface (GFS 2026-11-25 18Z, the mapped domain): 5,064 to 5,924 m.
# The figure where_is_500hpa.png was drawn with these values: mountains as triangles, pressure-level lines,
# a band for today's 500 hPa range, a sky shaded by pressure, and a secondary pressure axis (sec_axis(~ p_of_z(. * 1000))).
