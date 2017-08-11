best <- function(state, outcome) {
  ## Read outcome data
  dados <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  col <- ""
  ## Check that state and outcome are valid
  if(length(dados$State[dados$State==state]) == 0)
  {
    stop("invalid state");
  }
  if(!( outcome %in% c("heart attack", "heart failure", "pneumonia")))
  {
    stop("invalid outcome");
  }
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  if(outcome == "heart attack")
  {
    col <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  }
  else if (outcome == "heart failure")
  {
    col <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  }
  else if(outcome == "pneumonia")
  {
    col <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  }
  
  dados[[col]] <- as.numeric(dados[[col]])
  dados_filtrados <- dados[dados$State == state,]
  minimo <- min(dados_filtrados[[col]], na.rm = TRUE)
  dados_filtrados <- dados_filtrados[dados_filtrados[[col]]==minimo,]
  dados_filtrados <- dados_filtrados[order(dados_filtrados$Hospital.Name),]
  #dados_filtrados
  dados_filtrados[1,"Hospital.Name"]
}