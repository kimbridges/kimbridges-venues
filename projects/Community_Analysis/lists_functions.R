## Functions

## Index
##  - read_lists
##  - species_list
##  - species_freq_plot
##  - site_freq_plot
##  - data_to_2way
##  - species_dendrogram
##  - site_dendrogram

read_lists <- function(data_rows){
  
  # Read in the table rows  
  data <- read.table(header = FALSE, sep = ",", fill = TRUE, 
                     stringsAsFactors = FALSE, text=data_rows)
  
  ## Name the columns
  no_spp <- ncol(data)-1
  colnames(data) <- c("Site",paste0("spp",seq_len(no_spp)))
  
  return(data)
  
} ## end function read_lists

#######################################################

species_list <- function(data=data){
  
  ## Data table from wide to long
  data_long <- data |>
    pivot_longer(cols=starts_with("spp"),
                 values_to = "Species") |>
    filter(Species != "") 
  
  ## How many distinct species
  spp_list <- data_long |>
    distinct(Species) |>
    arrange(Species)
  
  return(spp_list)
} ## end function species_list

#######################################################

species_freq_plot <- function(data,data_source){
  
  ## Data table from wide to long
  data_long <- data |>
    pivot_longer(cols=c(spp1,spp2,spp3,spp4,spp5),
                 values_to = "Species") |>
    filter(Species != "") 
  
  ## Species frequencies
  spp_freq <- data_long |>
    count(Species)
  
  ## Plot the frequency diagram
  spp_freq_plot <- ggplot(data=spp_freq, aes(x=reorder(Species,-n))) +
    geom_bar(aes(weight=n), 
             fill="darkgoldenrod2", 
             color="black") +
    labs(x="Species", y="Species Frequency",
         caption = data_source) +
    coord_flip() +
    theme(panel.background = element_rect(fill = "lightblue",
                                          color= "black"))
  return(spp_freq_plot)
  
} ## end species_freq_plot function

#######################################################

site_freq_plot <- function(data,data_source){
  
  ## Data table from wide to long
  data_long <- data |>
    pivot_longer(cols=c(spp1,spp2,spp3,spp4,spp5),
                 values_to = "Species") |>
    filter(Species != "") 
  
  ## Site frequencies
  site_freq<- data_long |>
    count(Site)
  
  site_f_plot <- ggplot(data=site_freq, aes(x=reorder(Site,-n))) +
    geom_bar(aes(weight=n), 
             fill="darkgoldenrod2", 
             color="black") +
    labs(x="Sites", y="Site Frequency",
         caption = data_source) +
    coord_flip() +
    theme(panel.background = element_rect(fill = "lightblue",
                                          color= "black"))
  
  return(site_f_plot)
  
} ## end site_freq_plot

#######################################################

data_to_2way <- function(data){
  
  ## Data table from wide to long
  data_long <- data |>
    pivot_longer(cols=c(spp1,spp2,spp3,spp4,spp5),
                 values_to = "Species") |>
    filter(Species != "") 
  
  ## Start by making a data column (presence) and removing names
  data_long2 <- data_long |>
    mutate(presence = 1) |>
    select(-name)
  
  ## Make table wide and fill "missing" with zero
  data_2way <- data_long2 |>
    pivot_wider(names_from = Site,
                values_from = presence,
                values_fill = 0) 
  
  ## Sort the table
  data_2way <- data_2way |>
    arrange(Species)
  
  return(data_2way)
  
} ## end function data_to_2way

#######################################################

species_dendrogram <- function(data_2way){
  
  ## Save a list of species names
  spp_lab <- trimws(data_2way$Species)
  
  ## Remove the Species column from the table
  twoway <- data_2way |>
    select(-Species)
  
  ## Species similarities and clustering
  hc <- hclust(dist(twoway, method = "binary"))
  
  ## Extract the data
  hcdata <- dendro_data(hc, type = "rectangle")
  
  ## Restore the species names
  new_list <- NULL
  lab_list <- hcdata$labels$label
  for(i in 1:length(lab_list)){
    item_no <- as.numeric(lab_list[[i]])
    spp_name <- spp_lab[[item_no]]
    new_list[[i]] <- spp_name }
  hcdata$labels$label <- new_list
  
  ## Plot the dendrogram
  spp_plot <- ggplot() +
    geom_segment(data = segment(hcdata), 
                 aes(x=x, y=y, xend=xend, yend=yend)) +
    geom_text(data = label(hcdata), 
              aes(x=x, y=y, label=label, hjust=0), size = 3) +
    coord_flip() +
    labs(y="dissimilarity", caption = data_source) +
    scale_y_reverse(expand = c(0.2, 0)) +
    dendro_theme()
  
  return(spp_plot)
  
} ## end species_dendrogram

#######################################################

site_dendrogram <- function(data_2way){
  
  ## Remove the Species column from the table
  twoway <- data_2way |>
    select(-Species)
  
  ## Transpose to get site similarities
  twoway2 <- as.matrix(t(twoway))
  
  ## Site similarities and clustering
  hdist <- dist(twoway2, method = "binary")
  
  ## Check to fix an error that may sometime occur
  hclust_dist<- as.dist(hdist)
  hclust_dist[is.na(hclust_dist)] <- 0
  hclust_dist[is.nan(hclust_dist)] <- 0
  ## sum(is.infinite(hclust_dist))  # THIS SHOULD BE 0
  
  ## Do the clustering
  hc2 <- hclust(hclust_dist, "single")
  
  ## Generate the dendro data
  hcdata <- dendro_data(hc2, type = "rectangle")
  
  ## Trim the labels so no blanks
  hcdata$labels$label <- trimws(hcdata$labels$label)
  
  ## Plot using ggplot2 functionality
  site_plot <- ggplot() +
    geom_segment(data = segment(hcdata), 
                 aes(x=x, y=y, xend=xend, yend=yend)) +
    geom_text(data = label(hcdata), 
              aes(x=x, y=y, label=label, hjust=0), size = 3) +
    coord_flip() +
    labs(y="dissimilarity", caption = data_source) +
    scale_y_reverse(expand = c(0.2, 0)) +
    dendro_theme()
  
  return(site_plot)
  
} ## end site_dendrogram

#######################################################