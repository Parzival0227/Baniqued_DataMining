

library(arules)
library(arulesViz)
data("Groceries")
summary(Groceries)


frequent_items <- apriori(Groceries, parameter = list(supp = 0.01, target = "frequent itemsets"))
inspect(head(frequent_items))
rules <- apriori(Groceries, parameter = list(supp = 0.01, conf = 0.5))
inspect(head(rules))
rules_lift <- sort(rules, by = "lift", decreasing = TRUE)
inspect(head(rules_lift))

plot(head(rules_lift, 20), method = "graph", engine = "htmlwidget")
plot(rules, method = "scatterplot")
