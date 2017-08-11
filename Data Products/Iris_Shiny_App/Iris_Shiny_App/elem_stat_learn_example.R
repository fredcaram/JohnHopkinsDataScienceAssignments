library(ElemStatLearn)
require(class)

test_k <- function(k){
  set.seed(1919)
  
  result <- {}
  result$k <- k
  
  ## Create Examples
  result$x <- mixture.example$x
  result$g <- mixture.example$y
  result$xnew <- mixture.example$xnew
  
  ##Train the model
  result$knn_model <- knn(result$x, result$xnew, result$g, k=result$k, prob=TRUE)
  
  ## Get the model probabilities
  result$prob <- attr(result$knn_model, "prob")
  result$prob <- ifelse(result$knn_model=="1", result$prob, 1-result$prob)
  
  ## Get the points in the example
  result$px1 <- mixture.example$px1
  result$px2 <- mixture.example$px2
  
  ## Build a matrix with the probabilities
  result$prob_k <- matrix(result$prob, length(result$px1), length(result$px2))
  
  ## Get the estimated result
  result$test_model <- knn(result$x, result$x, result$g, k=result$k, prob=TRUE)
  result$ghat <- ifelse(result$test_model=="1", 1, 0)
  result$acc <- mean(result$ghat==result$g)
  result$misclass <- 1 - result$acc
  
  result
}

plot_k <- function(result){
  ## Plot the knn
  par(mar=rep(2,4))
  contour(result$px1, result$px2, result$prob_k, levels=0.5, labels="", xlab="", ylab="", main=
            paste0(result$k,"-nearest neighbour"), axes=FALSE)
  points(result$x, col=ifelse(result$g==1, "coral", "cornflowerblue"))
  gd <- expand.grid(x=result$px1, y=result$px2)
  points(gd, pch=".", cex=1.2, col=ifelse(result$prob_k>0.5, "coral", "cornflowerblue"))
  box()
}