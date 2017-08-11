library(datasets)
library(kknn)
library(reshape2)



  data("iris3")
  set.seed(1919)
  test_index <- sample(1:nrow(iris3), nrow(iris3) / 5, replace = FALSE)
  iris3_train <- iris3[-test_index,,]
  iris3_test <- iris3[test_index,,]
  
  iris_train <- dcast(melt(iris3_train), Var1 + Var3 ~ Var2)
  names(iris_train) <- make.names(names(iris_train))
  iris_test <- dcast(melt(iris3_test), Var1 + Var3 ~ Var2)
  names(iris_test) <- make.names(names(iris_test))
  
  iris_fit <- train.kknn(Var3 ~ Sepal.L. + Sepal.W. + Petal.L. + Petal.W., iris_train, ks = 1:50)
  iris_pred <- predict(iris_fit, iris_test[,,3:6])
  pred_table <- table(iris_test$Var3, iris_pred)
  
  accuracy <- (sum(diag(pred_table)))/sum(pred_table)
  
  plot(iris_fit, t="l")
