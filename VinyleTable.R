
# 
# install.packages("htmltools")
library(htmltools)
library(writexl)
library(stringr)
library(stringi)
library(readxl)

chr <- function(n) { rawToChar(as.raw(n)) }

Copie.Presse.Papier <- function(string) {
      os <- Sys.info()[['sysname']]
      if (os == "Windows") { # Si systeme dexploitation windows
            return(utils::writeClipboard(string))
      } else if (os == "Darwin") { # Si systeme dexploitation iOS
            Mac.Copie.Presse.Papier <- function(string){
                  presse.papier <- pipe("pbcopy", "w")
                  cat(string, file = presse.papier, sep = "\n")
                  close(presse.papier)	# Fermer lobjet presse-papier
            }
            return(Mac.Copie.Presse.Papier(string))
      }
}

path.to.images.folder.Old <- "/Users/gabriellemyre/Documents/GitHub/GabrielLemyre.github.io/images INPUT"
path.to.images.folder <- "/Users/gabriellemyre/Documents/GitHub/GabrielLemyre.github.io/images OUTPUT"
# albums <- list.files(path.to.images.folder.Old)
# 
# albums <- matrix(albums,length(albums),1)
# 
# Albums.noExt <- unlist(strsplit(albums,".jpg"))
# 
# Albums.info <- do.call(rbind, strsplit(Albums.noExt," - "))
# 
# Albums.info.full <- data.table(cbind(Albums.info,albums))
# names(Albums.info.full) <- c("Artist","Album","Path")
# 
# Albums.info.full[, Path := stri_trans_general(str = Path, 
#                                    id = "Latin-ASCII")]
# Albums.info.full$Path <- gsub("\\?", "", Albums.info.full$Path)
# Albums.info.full$Path <- gsub("\\'", "", Albums.info.full$Path)
# 
# file.rename(paste(path.to.images.folder,list.files(path.to.images.folder),sep="/"), paste(path.to.images.folder,Albums.info.full[["Path"]],sep="/"))
# 
# # Order
# Albums.info.full.Ordered <- Albums.info.full[order(Albums.info.full[["Artist"]],Albums.info.full[["Album"]]),]

# write_xlsx(Albums.info.full.Ordered,paste("/Users/gabriellemyre/Documents/GitHub/GabrielLemyre.github.io/VinyleTable.xlsx"))

Album_data <- read_excel(paste("/Users/gabriellemyre/Documents/GitHub/GabrielLemyre.github.io/VinyleTable.xlsx"))

tableWeb <- paste("<tr>\n",
            "\t<!-- Path to the image -->\n",
            "\t<td, class=\"highlight\"><img src=\"images OUTPUT\\",Album_data[["Path"]],"\" alt=\"",Album_data[["Album"]],"\" style='border:2px solid #FFFFFF' height=200></img></th>\n",
            "\t<td>",Album_data[["Album"]],"</th>\n",
            "\t<td>",Album_data[["Artist"]],"</th>\n",
            "\t<td>","","</th>\n",
            "\t<td>",Album_data[["Owner"]],"</th>\n",
      "</tr>\n",sep="")

Copie.Presse.Papier(tableWeb)
