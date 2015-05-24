library(shiny)
library(datasets)
dt <- data.frame()

shinyServer(function(input, output) {
  
 
 
 # EMI = [P x R x (1+R)^N]/[(1+R)^N-1]
 # P - principle 
 # R - Interest per month. if year year/(12*100)
 # N - number of monthly installements
  monthlyEMI <- eventReactive(input$submit, {
  	    p <- input$amount
  	    r <- input$interest
  	    n <- input$tenure
  	    r <- r/(12*100)
  	    emin <- (p*r*(1+r)^n)
  	    emid <- (((1+r)^n)-1)
  	    emi  <- emin/emid
  	    
	    tp <- n * emi
	    ti <- (tp - p)
	    balance <- tp
	    dt <- data.frame();
	    # num of months
	    nofm <- n+1 

	     for ( i in 1:nofm )
	     {
		mi <- (balance * r)
		mp <- (emi - mi)
		dt <- rbind(dt, c(i,emi,round(mp),round(mi),round(balance)))
		balance <- balance - emi
	     }
	     names(dt) <- c("Payment", "Monthly EMI", "Principle", "Interest", "Balance")
  	    
  	    output$view <- renderTable({dt})
  	    round(emi)
  })
  
  output$monthlyEMI <- renderText({
  	    monthlyEMI()
  })
  
 
  
  # Show the first "n" observations
  output$view <- renderTable({
	     dt
  })
})
