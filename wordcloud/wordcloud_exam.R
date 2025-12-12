#PART 1
getwd("C:/Users/LIENARD/wordcloud")
install.packages(c("tm", "SnowballC", "wordcloud", "RColorBrewer"))

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

text <- readLines("feedback.txt", encoding = "UTF-8", warn=FALSE)
text <- paste(text, collapse = " ")

corpus <- Corpus(VectorSource(text))   # Create the Corpus
corpus <- tm_map(corpus, content_transformer(tolower)) # Convert to lowercase 
#remove anything that is not a letter and space
corpus <- tm_map(corpus, content_transformer(function(x) gsub("[^a-z ]", " ", x))) #remove a
corpus <- tm_map(corpus, removeNumbers) #remove all numbers
corpus <- tm_map(corpus, removeWords, stopwords("english")) #remove unnecessary words (is, the...)
corpus <- tm_map(corpus, stripWhitespace) #remove whitespace
corpus <- tm_map(corpus, stemDocument) #stem the words


#PART 2
tdm <- TermDocumentMatrix(corpus)
m <- as.matrix(tdm)
word_freqs <- sort(rowSums(m), decreasing = TRUE)
df <- data.frame(word = names(word_freqs), freq = word_freqs)
print("Top 10 Most Frequent Words")
str(df)
head(df, 10)
# Interpretation of the results:
# The top words show that customers are most concerned with 
  # service, staff, and the restaurant experience.
  # Frequent mentions of “process,” “slow,” and “line” indicate that 
  # speed and efficiency are major issues. 
  # Overall, feedback suggests that improving service flow and maintaining 
  # attentive staff are key priorities for customer satisfaction.



#PART 3
png("wordcloud_exam.png", width = 800, height = 600)

set.seed(112605)

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
head(df_rare, 5)


png("wordcloud_rare.png", width = 800, height = 600)

set.seed(1000)

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





