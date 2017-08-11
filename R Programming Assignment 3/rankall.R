rankall <- function(outcome, num = "best") {
  ## Read outcome data
  dados <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  col <- ""
  ## Check that state and outcome are valid
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
  dados_filtrados <- dados[!is.na(dados[[col]]),]
  sinal <- 1
  if(num == "best")
  {
    indice <- 1
  }
  else if (num == "worst")
  {
    indice <- 1
    sinal <- -1;
  }
  else
  {
    indice <- as.numeric(num);
  }
  ## For each state, find the hospital of the given rank
  dados_filtrados <- dados_filtrados[order(sinal * dados_filtrados[[col]], dados_filtrados$Hospital.Name),]
  resultado <- do.call(rbind,by(dados_filtrados,dados_filtrados$State,function(x) x[indice,]))
  resultado[,"State"][is.na(resultado[,"State"])] <- row.names(resultado)[is.na(resultado[,"State"])]
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  resultado <- resultado[, c("Hospital.Name", "State")]
  colnames(resultado) <- c("hospital", "state")
  resultado
}