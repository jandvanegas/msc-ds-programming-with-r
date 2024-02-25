library(plotly)
library(ggplot2)
library(dplyr)
library(highcharter)


#============#
# ggplotly() #
#============#

# Scatter & Line
set.seed(1234)

n <- 20

x1 <- rnorm(n); x2 <- rnorm(n)
y1 <- 2 * x1 + rnorm(n)
y2 <- 3 * x2 + (2 + rnorm(n))
A <- as.factor(rep(c(1, 2), each = n))
df <- data.frame(x = c(x1, x2), y = c(y1, y2), A = A)
fm <- lm(y ~ x + A, data = df)

p <- ggplot(data = cbind(df, pred = predict(fm)), aes(x = x, y = y, color = A))
p <- p + geom_point() + geom_line(aes(y = pred))

ggplotly(p)


# Barplot

set.seed(123)

df <- diamonds[sample(1:nrow(diamonds), size = 1000),]

df.summ <- df %>% group_by(cut) %>% summarize(Mean = mean(table), Min = min(table), Max = max(table))

p <- ggplot(df.summ, aes(x = cut, y = Mean, ymin = Min, ymax = Max, fill = cut)) + 
  geom_bar(stat = "identity") + 
  geom_errorbar() + 
  ggtitle("Bar chart with Error Bars")

ggplotly(p)


# Boxplot

set.seed(1234)
dat <- data.frame(cond = factor(rep(c("A","B"), each=200)), rating = c(rnorm(200),rnorm(200, mean=.8)))

p <- ggplot(dat, aes(x=cond, y=rating, fill=cond)) + geom_boxplot()

ggplotly(p)



# Tooltip
str(starwars)
colnames(starwars)
# [1] "name"    "height"     "mass"       "hair_color" "skin_color" "eye_color"  "birth_year" "gender"  "homeworld" 
# [10] "species"    "films"      "vehicles"   "starships" 


p <- ggplot(data = starwars, aes(x=mass,y=height,col=species)) + geom_point()
ggplotly(p)

p <- ggplot(data = starwars, aes(x=mass,y=height,col=species,text=paste0("name: ",name,"\nhomeworld: ",homeworld))) + 
  geom_point()
ggplotly(p)


#===========#
# plot_ly() #
#===========#

# Example 1
dens <- with(diamonds, tapply(price, INDEX = cut, density))
df <- data.frame(
  x = unlist(lapply(dens, "[[", "x")),
  y = unlist(lapply(dens, "[[", "y")),
  cut = rep(names(dens), each = length(dens[[1]]$x))
)
str(df)

plot_ly(df, x = ~x, y = ~y, color = ~cut) %>%
  add_lines()


# Example 2
str(economics)
data("economics")

plot_ly(economics, x = ~date, y = ~uempmed)

plot_ly(economics, x = ~date, y = ~uempmed, type="scatter", mode="lines")

# schema() # Which modes for which type? (traces -> scatter -> attributes -> mode)

plot_ly(economics, x = ~date, y = ~uempmed, type="scatter", mode="lines", name ="uempmed trace") %>%
  add_trace(y=~psavert,name="trace psavert",mode="lines+markers")


plot_ly(data=economics, x = ~date, y = ~uempmed, type="scatter", mode="lines") %>% 
  add_trace(y = fitted(loess(uempmed ~ as.numeric(date),economics))) %>%
  layout(title = "Median duration of unemployment (in weeks)", showlegend=FALSE) %>%
  layout(data=filter(.data=economics,uempmed == max(uempmed)),
         annotations = list(x = ~date, y = ~uempmed, text = "Peak", showarrow = T))


# Example 3 (matrix)

str(volcano)
plot_ly(z = volcano, type="surface")



# # Different Types
# type = c('scatter', 'bar', 'box', 'heatmap', 'histogram', 'histogram2d', 'histogram2dcontour', 'pie', '
# contour', 'scatterternary', 'violin', 'scatter3d', 'surface', 'mesh3d', 'cone', 'streamtube', 
# 'scattergeo', 'choropleth', 'scattergl', 'splom', 'pointcloud', 'heatmapgl', 'parcoords', 
# 'scattermapbox', 'sankey', 'table', 'carpet', 'scattercarpet', 'contourcarpet', 'ohlc', 
# 'candlestick', 'scatterpolar', 'scatterpolargl', 'area')



###########
# hcart() #
###########



# Example 1

data("economics_long",package="ggplot2")
economics_long2 <- economics_long %>% filter(variable %in% c("pop", "uempmed", "unemploy")) %>% print()

hchart(economics_long2, "line", hcaes(x = date, y = value01, group = variable))


