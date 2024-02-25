


library(ggplot2)
str(iris)
# 'data.frame':	150 obs. of  7 variables:
# $ Sepal.Length     : num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width      : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length     : num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width      : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species          : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

iris$Petal.Length.Disc <- factor(ifelse(iris$Petal.Length>=mean(iris$Petal.Length),"LargePetalLength","SmallPetalLength"),
                                 levels=c("SmallPetalLength","LargePetalLength"))
iris$Petal.Width.Disc <- factor(ifelse(iris$Petal.Width>=mean(iris$Petal.Width),"LargePetalWidth","SmallPetalWidth"),
                                levels=c("SmallPetalWidth","LargePetalWidth"))


ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width))


ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width)) + 
  geom_point()



ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width)) + 
  geom_point() + 
  labs(x="Length of Sepal",y="Width of Sepal") + ggtitle("Scatter Plot of Iris Data")



ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species)) + 
  geom_point() + 
  labs(x="Length of Sepal",y="Width of Sepal") + ggtitle("Scatter Plot of Iris Data") 



ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species,shape=Species)) + 
  geom_point() + 
  labs(x="Length of Sepal",y="Width of Sepal") + ggtitle("Scatter Plot of Iris Data")


ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Petal.Length,shape=Species)) + 
  geom_point() + 
  labs(x="Length of Sepal",y="Width of Sepal") + ggtitle("Scatter Plot of Iris Data")


ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Petal.Length,shape=Species)) + 
  geom_point() + 
  labs(x="Length of Sepal",y="Width of Sepal") + ggtitle("Scatter Plot of Iris Data") + 
  scale_color_continuous(type="viridis")

  # scale_color_manual, scale_fill_manual for discrete colors
  # scale_color_gradient, scale_color_gradientn for manual continous colors


ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species,shape=Species)) + 
  geom_point() + 
  labs(x="Length of Sepal",y="Width of Sepal") + ggtitle("Scatter Plot of Iris Data") + 
  facet_wrap(~Species)



ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species,shape=Species)) + 
  geom_point() + 
  labs(x="Length of Sepal",y="Width of Sepal") + ggtitle("Scatter Plot of Iris Data") + 
  facet_grid(Petal.Length.Disc~Petal.Width.Disc)


ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species,shape=Species)) + 
  geom_point() + 
  labs(x="Length of Sepal",y="Width of Sepal") + ggtitle("Scatter Plot of Iris Data") + 
  facet_grid(Petal.Length.Disc~Petal.Width.Disc) + 
  theme_bw()



ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species,shape=Species)) + 
  geom_point() + 
  labs(x="Length of Sepal",y="Width of Sepal") + ggtitle("Scatter Plot of Iris Data") + 
  facet_grid(Petal.Length.Disc~Petal.Width.Disc) + 
  theme_bw() + 
  scale_y_continuous(breaks=seq(2,6,1)) 



ggplot(iris,aes(x=Species,y=Sepal.Length)) + 
  geom_boxplot() + 
  geom_jitter(width=0.2,height=0,aes(col=Sepal.Width)) + 
  scale_color_continuous(type="viridis") + 
  theme_bw()  



