a <- 10
b <- 5

print("1: Add, 2: Subtract, 3: Multiply, 4: Divide")
operation = readline("Enter Number: ")

result <- switch(operation,
                 "1" = a + b,
                 "2" = a - b,
                 "3" = a * b,
                 "4" = a / b, "Invalid Operation"
)
print(result)