albums <- list.files("/Users/gabriellemyre/Library/Mobile Documents/com~apple~CloudDocs/25 - Musique/1 - Vinyles")

Albums.noExt <- unlist(strsplit(albums,".jpg"))

Albums.info <- do.call(rbind, strsplit(Albums.noExt," - "))
