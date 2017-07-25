library(plotly)

p <- plot_ly(mtcars, x = ~wt, y = ~hp, z = ~qsec,
             marker = list(color = ~mpg, colorscale = c('#FFE1A1', '#683531'), showscale = TRUE)) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Weight'),
                      yaxis = list(title = 'Gross horsepower'),
                      zaxis = list(title = '1/4 mile time')),
         annotations = list(
           x = 1.13,
           y = 1.05,
           text = 'Miles/(US) gallon',
           xref = 'paper',
           yref = 'paper',
           showarrow = FALSE
         ))

p


library(plotly)

x <- c()
y <- c()
z <- c()
c <- c()

for (i in 1:62) {
  r <- 20 * cos(i / 20)
  x <- c(x, r * cos(i))
  y <- c(y, r * sin(i))
  z <- c(z, i)
  c <- c(c, i)
}

data <- data.frame(x, y, z, c)

p <- plot_ly(data, x = ~x, y = ~y, z = ~z, type = 'scatter3d', mode = 'lines+markers',
             line = list(width = 6, color = ~c, colorscale = 'Viridis'),
             marker = list(size = 3.5, color = ~c, colorscale = 'Greens', cmin = -20, cmax = 50))
p