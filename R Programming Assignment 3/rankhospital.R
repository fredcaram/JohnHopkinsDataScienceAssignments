rankhospital <- function(state, outcome, num = "best") {
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
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  dados[[col]] <- as.numeric(dados[[col]])
  dados_filtrados <- dados[dados$State == state,]
  dados_filtrados <- dados_filtrados[!is.na(dados_filtrados[[col]]),]
  if(num == "best")
  {
    resultado <- 1
  }
  else if (num == "worst")
  {
    resultado <- length(dados_filtrados[[col]])
  }
  else
  {
    resultado <- as.numeric(num);
    if(!is.na(resultado) && resultado > length(dados_filtrados[[col]]))
    {
      resultado <- NA
    }
  }
  dados_filtrados <- dados_filtrados[order(dados_filtrados[[col]], dados_filtrados$Hospital.Name),]
  #head(dados_filtrados[,c("Hospital.Name", col)])
  if(is.na(resultado))
  {
    NA
  }
  else
  {
    dados_filtrados[resultado,"Hospital.Name"]
  }
}