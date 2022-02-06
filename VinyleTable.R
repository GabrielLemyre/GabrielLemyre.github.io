
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

Albums.info.full <- cbind(Albums.info,paste("images\\",albums,sep=""))

tableWeb <- paste("<tr>\n",
            "\t<!-- Path to the image -->\n",
            "\t<td><img src=\"",Albums.info.full[,3],"\" alt=\"",Albums.info.full[,2],"\" border=3 height=200 width=200></img></th>\n",
            "\t<td>",Albums.info.full[,2],"</th>\n",
            "\t<td>",Albums.info.full[,1],"</th>\n",
      "</tr>\n",sep="")

Copie.Presse.Papier(tableWeb)
