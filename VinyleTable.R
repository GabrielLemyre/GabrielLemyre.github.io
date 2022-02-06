
# 
# install.packages("htmltools")
library(htmltools)

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

path.to.images.folder <- "/Users/gabriellemyre/Documents/GitHub/GabrielLemyre.github.io/images"
albums <- list.files(path.to.images.folder)

albums <- matrix(albums,length(albums),1)

Albums.noExt <- unlist(strsplit(albums,".jpg"))

Albums.info <- do.call(rbind, strsplit(Albums.noExt," - "))

Albums.info.full <- data.table(cbind(Albums.info,paste("images\\",albums,sep="")))
names(Albums.info.full) <- c("Artist","Album","Path")
Albums.info.full.Ordered <- Albums.info.full[order(Albums.info.full[["Artist"]],Albums.info.full[["Album"]]),]

tableWeb <- paste("<tr>\n",
            "\t<!-- Path to the image -->\n",
            "\t<td><img src=\"",Albums.info.full.Ordered[["Path"]],"\" alt=\"",Albums.info.full.Ordered[["Path"]],"\" style='border:2px solid #FFFFFF' height=200 width=200></img></th>\n",
            "\t<td>",Albums.info.full.Ordered[["Album"]],"</th>\n",
            "\t<td>",Albums.info.full.Ordered[["Artist"]],"</th>\n",
            "\t<td>","","</th>\n",
            "\t<td>","Gabriel","</th>\n",
      "</tr>\n",sep="")

Copie.Presse.Papier(tableWeb)
