---
title: "Pubications"
date: 2023-08-28T03:25:08+03:00
draft: true
---

library("xlsx")
my_data <- read.xlsx(file = "publications.xlsx", sheetIndex = 1, 
                     header = TRUE, stringsAsFactors = FALSE)

my_data$Row <- row.names(my_data)
my_data <- my_data[order(my_data$Year, as.numeric(my_data$Row), 
                         decreasing = c(TRUE, TRUE)), ]
years <- sort(unique(my_data$Year), decreasing = TRUE)

for(year in years){
  cat(paste("\n","## ",year,sep=""))
  thisyear <- my_data[my_data$Year == year,]
  if(dim(thisyear)[1] > 0){
    cat("\n<ul>")
    for(i in 1:(dim(thisyear)[1])){
      cat(paste("\n<li>",sep = ""))
      cat(paste(thisyear$Author[i], " (",year,"). ",thisyear$Title[i], ". ", sep=""))
      if(!is.na(thisyear$Journal[i])){
        cat(paste("<i>",thisyear$Journal[i],"</i>. ",sep="")) 
      }
      if(!is.na(thisyear$Details[i])){ 
        cat(paste(thisyear$Details[i],sep="")) 
      }
      
      if(!is.na(thisyear$DOI[i])){
        cat(" <a href=\"http://dx.doi.org/",thisyear$DOI[i],"\" 
            target=\"_blank\">[DOI]</i></a>")  
      }
    }
    cat("\n</ul>")
  }
}
