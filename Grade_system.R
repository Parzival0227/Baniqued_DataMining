grade = "B"
result <- switch(grade,
                 "A" = "Excellent",
                 "B" = "Very Good",
                 "C" = "Good",
                 "D" = "Fair",
                 "F" = "Failed",
                 "Invalid Grade")
print(result)