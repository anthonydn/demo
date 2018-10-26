library(tidyverse)

a <- xml2::read_html("http://www.lascruces-weather.com/wxraindetail.php?year=2015") %>% 
  rvest::html_nodes("tr td") %>%
  rvest::html_text() %>%
  as.numeric
b <- matrix(a[1:403], nrow = 31, byrow = TRUE)[,-1] %>% 
  as.numeric() %>% 
  na.omit
cruces_rain_2015 <- data.frame(doy = 1:365, rainfall = b)

jorn15_scale <- function() scale_x_continuous(
  breaks = c(155, 168, 175, 182, 189, 196),
  limits = c(150, 198),
  labels = c("Jun 4", "Jun 17", "Jun 24", "Jul 1", "Jul 8", "Jul 15"))

ggplot(cruces_rain_2015, aes(doy, rainfall)) +
  geom_bar(stat = "identity", fill = "navyblue") +
  jorn15_scale()

##change