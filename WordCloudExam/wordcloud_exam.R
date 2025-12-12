#PART 1
setwd("C:/Users/LIENARD/Documents/DataMining/WordCloudExam")
install.packages(c("tm", "SnowballC", "wordcloud", "RColorBrewer"))

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

text <- readLines("feedback.txt", encoding = "UTF-8", warn=FALSE)
text <- paste(text, collapse = " ")

corpus <- Corpus(VectorSource(text))   
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, content_transformer(function(x) gsub("[^a-z ]", " ", x)))
corpus <- tm_map(corpus, removeNumbers) 
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, stemDocument)


#PART 2
tdm <- TermDocumentMatrix(corpus)
m <- as.matrix(tdm)
word_freqs <- sort(rowSums(m), decreasing = TRUE)
df <- data.frame(word = names(word_freqs), freq = word_freqs)
print("Top 10 Most Frequent Words")
print(head(df, 10))
# Interpretation of the results:
# The dominance of words like "seem" and "felt" reveals
# that customer feedback is driven primarily by subjective impressions.
# Frequent use of "better" and "need" signals a clear demand for service 
# improvements rather than just praise. Finally, the prominence of "time" 
# and "took" confirms that efficiency and wait times are the customers' biggest
# frustrations.


#PART 3
png("wordcloud_exam.png", width = 800, height = 600)

set.seed(1111)

wordcloud(
  words = df$word,
  freq = df$freq,
  min.freq = 2,
  max.words = 1000,
  random.order = FALSE,
  rot.per = 0.35,
  colors = brewer.pal(8, "Dark2")
)
dev.off()

#Part 4
df_rare <- subset(df, freq==1)

print("Least Frequent Words")
print(head(df_rare, 5))


png("wordcloud_rare.png", width = 800, height = 600)

set.seed(1010)

wordcloud(
  words = df_rare$word,
  freq = df_rare$freq,
  min.freq = 1,
  max.words = 1000,
  random.order = FALSE,
  rot.per = 0.35,
  colors = brewer.pal(8, "Dark2")
)

dev.off()





