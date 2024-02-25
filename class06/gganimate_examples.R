
########################
## gganimate Examples ##
########################


# install.packages(c("gganimate","gifski"))


library(ggplot2)
library(gganimate)
library(dplyr)
library(tidyr)
library(COVID19) # https://covid19datahub.io/


## Get Data ##

data <- covid19(country=c("Netherlands","Belgium","Germany","France","Spain","Austria","Italy","United Kingdom",
                          "United States","South Korea","Sweden","Luxembourg","Ireland"),start="2020-03-01")
# Remove last 2 days, may still be incomplete
data <- data[data$date<=(Sys.Date()-2),]
# Add confirmed daily cases
data <- data %>% arrange(date) %>% group_by(administrative_area_level_1) %>% mutate(confirmed_daily=c(.data$confirmed[1],diff(confirmed)))

# str(data)




## Animate Points through time ##

# Static

ggplot(data, aes(x=date,y=confirmed/population,col=administrative_area_level_1)) + geom_point() + theme_bw()


# Animated

my.animation <- ggplot(data, aes(x=date,y=confirmed/population,col=administrative_area_level_1)) + geom_point() + theme_bw() + 
  transition_time(date) + labs(title="Date: {frame_time}")

animate(my.animation,width=800,height=400)
anim_save(animation=last_animation(),file="InteractiveAnimatedPlots_Lesson/figures/gganimate_example1.gif")


my.animation <- ggplot(data, aes(x=date,y=confirmed/population,col=administrative_area_level_1)) + 
  geom_point(aes(size=population),alpha=0.7) + # Add transparency and size
  scale_size(range = c(2, 12)) + # Add range to scale of size
  theme_bw() + 
  transition_time(date) + labs(title="Date: {frame_time}") +
  shadow_wake(wake_length = 0.2) # Add trail to points

animate(my.animation,width=800,height=400)
save_animation(animation=last_animation(),file="InteractiveAnimatedPlots_Lesson/figures/gganimate_example2.gif")



## Animate Line Reveal ##  


# Static

ggplot(data, aes(x=date,y=confirmed/population,col=administrative_area_level_1)) + geom_line(size=1) + theme_bw()


# Animated

my.animation <- ggplot(data, aes(x=date,y=confirmed/population,col=administrative_area_level_1)) + geom_line(size=1) + theme_bw() + 
  transition_reveal(date) + labs(title="Date: {frame_along}")

animate(my.animation,width=800,height=400)
save_animation(animation=last_animation(),file="InteractiveAnimatedPlots_Lesson/figures/gganimate_example3.gif")


my.animation <- ggplot(data, aes(x=date,y=confirmed/population,col=administrative_area_level_1)) + geom_line(size=1) + theme_bw() + 
  transition_reveal(date) + labs(title="Date: {frame_along}") +
  geom_point(size=2) + 
  scale_y_log10()

animate(my.animation,width=800,height=400)
save_animation(animation=last_animation(),file="InteractiveAnimatedPlots_Lesson/figures/gganimate_example4.gif")


## Animate State Transition ##

# Static

ggplot(data,aes(x=administrative_area_level_1,y=confirmed/population,fill=administrative_area_level_1)) + 
  geom_bar(stat = "identity",col="black") + theme(axis.text.x = element_text(angle=60,hjust=1))


# Animated

my.animation <- ggplot(data,aes(x=administrative_area_level_1,y=confirmed/population,fill=administrative_area_level_1)) + 
  geom_bar(stat = "identity",col="black") + theme(axis.text.x = element_text(angle=60,hjust=1)) + 
  transition_states(date) + labs(title = "Date: {closest_state}")

animate(
  my.animation, 
  nframes = 2*length(unique(data$date)), # By default transition_states() has a limit of 100 frames. 
  fps = 28,                              #   We need more frames here due to many states (=number of dates)    
  end_pause = 8
)

save_animation(animation=last_animation(),file="InteractiveAnimatedPlots_Lesson/figures/gganimate_example5.gif")



# Static

ggplot(data,aes(x=date,y=confirmed/population,col=administrative_area_level_1)) + 
  geom_point(size=2) + theme_bw()


# Animated

my.animation <- ggplot(data,aes(x=date,y=confirmed/population,col=administrative_area_level_1)) + 
  geom_point(size=2) + theme_bw() + 
  transition_states(administrative_area_level_1) + labs(title="Country: {closest_state}")

animate(my.animation,width=800,height=400)
save_animation(animation=last_animation(),file="InteractiveAnimatedPlots_Lesson/figures/gganimate_example6.gif")


my.animation <- ggplot(data,aes(x=date,y=confirmed/population,col=administrative_area_level_1)) + 
  geom_point(size=2,aes(group=1L)) + theme_bw() +  # Setting the group parameter ensures that the line "morphs" between states
  transition_states(administrative_area_level_1,transition_length = 2) + labs(title="Country: {closest_state}")

animate(my.animation,width=800,height=400)
save_animation(animation=last_animation(),file="InteractiveAnimatedPlots_Lesson/figures/gganimate_example7.gif")


my.animation <- ggplot(data,aes(x=date,y=confirmed/population,col=administrative_area_level_1)) + 
  geom_point(size=2) + theme_bw() + 
  transition_states(administrative_area_level_1,transition_length = 4) + labs(title="Country: {closest_state}") +
  enter_fade() +
  exit_shrink()
  # enter_drift() # Options to slide the points in and out from the side
  # exit_drift 

animate(my.animation,width=800,height=400)
save_animation(animation=last_animation(),file="InteractiveAnimatedPlots_Lesson/figures/gganimate_example8.gif")

