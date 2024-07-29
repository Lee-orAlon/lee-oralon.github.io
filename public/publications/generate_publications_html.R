# Load the CSV data
my_data <- read.csv("publications.csv", header = TRUE, stringsAsFactors = FALSE)

my_data$Row <- row.names(my_data)
my_data <- my_data[order(my_data$Year, as.numeric(my_data$Row), 
                         decreasing = c(TRUE, TRUE)), ]
my_data <- my_data[order(-my_data$Year, -my_data$Month, as.numeric(my_data$Row)), ]
years <- sort(unique(my_data$Year), decreasing = TRUE)

for (year in years) {
  cat(paste("\n","## ",year,sep=""))
  thisyear <- my_data[my_data$Year == year,]
  if (dim(thisyear)[1] > 0) {
    cat("\n<ul>")
    for (i in 1:(dim(thisyear)[1])) {
      cat(paste("\n<li>",sep = ""))
      cat(paste(thisyear$Author[i], " (",year,"). <b>",thisyear$Title[i], "</b>. ", sep=""))
      if (!is.na(thisyear$Journal[i])) {
        cat(paste("<i>",thisyear$Journal[i],"</i>. ",sep="")) 
      }
      
      if (!is.na(thisyear$PDF_file[i])) {
        cat(" <a href=\"",thisyear$PDF_file[i],"\" 
            target=\"_blank\">[pdf]</i></a>")  
      }
      
      if (!is.na(thisyear$Details[i])) { 
        cat(paste(thisyear$Details[i],sep="")) 
      }
    }
    cat("\n</ul>\n")
  }
}

