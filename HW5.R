library(RCurl)
library(XML)


library(stringr)
url    = paste("http://shakespeare.mit.edu/romeo_juliet/full.html")
#url    = paste("http://shakespeare.mit.edu/julius_caesar/full.html")
#url    = paste("http://shakespeare.mit.edu/hamlet/full.html")

abs    = lapply(url, FUN = function(x) htmlParse(x, encoding = "ANSI"))
clean_txt = function(x) {
        cleantxt = xpathApply(x, "//body//text()
                              [not(ancestor :: script)][ not(ancestor :: style)] 
                              [not(ancestor :: noscript)] " ,xmlValue)
        
        cleantxt = paste(cleantxt, collapse="\n")
        cleantxt = str_replace_all(cleantxt, "\n", " ")
        cleantxt = str_replace_all(cleantxt, "\r", "")
        cleantxt = str_replace_all(cleantxt, "\t", "")
        cleantxt = str_replace_all(cleantxt, "<br>", "")
        return(cleantxt)
}

cleantxt = lapply(abs,clean_txt)
vec_abs = unlist(cleantxt)

library(NLP)
library(tm)
library(SnowballC)

abs      = Corpus(VectorSource(vec_abs))
abs_dtm  = DocumentTermMatrix(abs, control = list(stemming = TRUE, stopwords = TRUE, minWordLength = 3,
                                                  removeNumbers = TRUE, removePunctuation = TRUE))

dim(abs_dtm)
inspect(abs_dtm)

findFreqTerms(abs_dtm, 3)

removeSparseTerms(abs_dtm, 0.5)
inspect(removeSparseTerms(abs_dtm, 0.5))

library(ggplot2) 
library(wordcloud)

freq = colSums(as.matrix(abs_dtm))   
wf   = data.frame(word=names(freq), freq=freq)   
plot = ggplot(subset(wf, freq>50), aes(word, freq))    
plot = plot + geom_bar(stat="identity")   
plot = plot + theme(axis.text.x=element_text(angle=45, hjust=1))   
plot  

freq  = colSums(as.matrix(abs_dtm))   
dark2 = brewer.pal(6, "Dark2")   
wordcloud(names(freq), freq, max.words=100, rot.per=0.2, colors=dark2)    

