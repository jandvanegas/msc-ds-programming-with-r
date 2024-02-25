library(shiny)
runExample("01_hello")

ui <- fluidPage(
  
  # App title ----
  titlePanel("Hello Shiny!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot")
      
    )
  )
)

ui


names(tags)

tags$strong("Bold Font")

strong("Bold Font")



ui <- fluidPage(
  
  tags$div(
    
    h1("Hello Shiny"),
    
    hr(),
    
    p(strong("bold font "),em("italic font")),
    
    p(code("code block"))
    
  )
)

ui


# shinyApp(ui=ui,server=function(input, output){})
