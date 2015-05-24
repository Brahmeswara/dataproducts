library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title.
  titlePanel("EMI Calculator"),
 
  sidebarLayout(
    sidebarPanel(
      helpText("Note: Please enter loan amount, tenure of the loan in months and interest rate and then press the Calcualate EMI button."),
      numericInput("amount", "Loan Amount:", 10),
      numericInput("tenure", "Loan Duration (in months):", 10),
      numericInput("interest", "Inerest Rate:", 10),
      actionButton("submit", "Calculate EMI")
    ),
    
    # Show a summary of the dataset and an HTML table with the
    # requested number of observations. Note the use of the h4
    # function to provide an additional header above each output
    # section.
    mainPanel(
      h4("Monthly Payment is "),
      verbatimTextOutput("monthlyEMI"),
      
      h4("Amortization Schedule"),
      tableOutput("view")
    )
  )
))
