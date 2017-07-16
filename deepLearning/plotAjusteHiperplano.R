#install.packages("plotly")
library(plotly)
trace1 <- list(
  x = c("1", "2", "3", "4", "5", "6"), 
  y = c("18653", "15497", "17973", "18125", "13559", "10109"), 
  connectgaps = FALSE, 
  line = list(shape = "spline"), 
  marker = list(opacity = 1), 
  mode = "lines+markers", 
  name = "Real", 
  showlegend = TRUE, 
  type = "scatter", 
  uid = "26806d", 
  xsrc = "robs.fernandes:0:d9ec2c", 
  ysrc = "robs.fernandes:0:09c1d7"
)
trace2 <- list(
  x = c("1", "2", "3", "4", "5", "6"), 
  y = c("17570.4710", "15115.1073", "18755.8545", "18760.7579", "13930.0441", " 9783.7652"), 
  line = list(
    shape = "spline", 
    width = 3
  ), 
  marker = list(size = 6), 
  mode = "lines+markers", 
  name = "RB - MMHC", 
  type = "scatter", 
  uid = "f8b0f8", 
  xsrc = "robs.fernandes:0:d9ec2c", 
  ysrc = "robs.fernandes:0:662bfe"
)
trace3 <- list(
  x = c("1", "2", "3", "4", "5", "6"), 
  y = c("19429.4330", "15586.0160", "18572.6032", "19441.4428", "12903.0879", " 7983.4172"), 
  line = list(shape = "spline"), 
  mode = "lines+markers", 
  name = "RB - HC", 
  type = "scatter", 
  uid = "b933cd", 
  xsrc = "robs.fernandes:0:d9ec2c", 
  ysrc = "robs.fernandes:0:dac376"
)
trace4 <- list(
  x = c("1", "2", "3", "4", "5", "6"), 
  y = c("19876.3599", "15310.3814", "19598.7202", "18803.9633", "12640.9136", " 7685.6616"), 
  line = list(shape = "spline"), 
  mode = "lines+markers", 
  name = "RB - Tabu", 
  type = "scatter", 
  uid = "424c40", 
  xsrc = "robs.fernandes:0:d9ec2c", 
  ysrc = "robs.fernandes:0:9b9800"
)
trace5 <- list(
  x = c("1", "2", "3", "4", "5", "6"), 
  y = c("17205.9730", "14729.9287", "17995.8214", "19046.6093", "14379.7355", "10557.9321"), 
  line = list(shape = "spline"), 
  mode = "lines+markers", 
  name = "RB - RSMAX2", 
  type = "scatter", 
  uid = "3ff1dd", 
  xsrc = "robs.fernandes:0:d9ec2c", 
  ysrc = "robs.fernandes:0:73b130"
)
trace6 <- list(
  x = c("1", "2", "3", "4", "5", "6"), 
  y = c("20107.5813", "15332.9123", "19675.5019", "18958.2365", "12504.7816", " 8793.4664"), 
  line = list(shape = "spline"), 
  mode = "lines+markers", 
  name = "RN - Backpropagation Resiliente", 
  type = "scatter", 
  uid = "605bb9", 
  xsrc = "robs.fernandes:0:d9ec2c", 
  ysrc = "robs.fernandes:0:aa0ea2"
)
data <- list(trace1, trace2, trace3, trace4, trace5, trace6)
layout <- list(
  autosize = FALSE, 
  dragmode = "zoom", 
  hidesources = FALSE, 
  hovermode = "closest", 
  legend = list(
    x = 0.999182272294, 
    y = 0.676470588235
  ), 
  paper_bgcolor = "#fff", 
  plot_bgcolor = "rgb(255, 255, 255)", 
  separators = ".,", 
  showlegend = TRUE, 
  smith = FALSE, 
  title = "Modelos ajustados no hiperplano<br><b>Vendas Mensais</b>", 
  xaxis = list(
    anchor = "y", 
    autorange = TRUE, 
    color = "#444", 
    domain = c(0, 1), 
    dtick = "M12", 
    exponentformat = "e", 
    fixedrange = FALSE, 
    gridcolor = "rgb(238, 238, 238)", 
    gridwidth = 1, 
    hoverformat = "", 
    nticks = 0, 
    range = c(0.683620529924, 6.31637947008), 
    rangemode = "normal", 
    rangeselector = list(visible = FALSE), 
    showexponent = "all", 
    showgrid = TRUE, 
    showline = FALSE, 
    showticklabels = TRUE, 
    side = "bottom", 
    tick0 = 946702800000, 
    tickangle = "auto", 
    tickfont = list(
      color = "#444", 
      family = "\"Open Sans\", verdana, arial, sans-serif", 
      size = 12
    ), 
    tickformat = "", 
    tickmode = "auto", 
    tickprefix = "", 
    ticks = "", 
    ticksuffix = "", 
    title = "Índice", 
    titlefont = list(
      color = "#444", 
      family = "\"Open Sans\", verdana, arial, sans-serif", 
      size = 14
    ), 
    type = "linear", 
    zeroline = TRUE, 
    zerolinecolor = "#444", 
    zerolinewidth = 1
  ), 
  yaxis = list(
    anchor = "x", 
    autorange = TRUE, 
    color = "#444", 
    domain = c(0, 1), 
    dtick = 50, 
    exponentformat = "B", 
    fixedrange = FALSE, 
    gridcolor = "rgb(238, 238, 238)", 
    gridwidth = 1, 
    hoverformat = "", 
    nticks = 0, 
    range = c(6822.16131935, 20971.0815807), 
    rangemode = "normal", 
    showexponent = "all", 
    showgrid = TRUE, 
    showline = FALSE, 
    showticklabels = TRUE, 
    side = "left", 
    tick0 = 0, 
    tickangle = "auto", 
    tickfont = list(
      color = "#444", 
      family = "\"Open Sans\", verdana, arial, sans-serif", 
      size = 12
    ), 
    tickformat = "", 
    tickmode = "auto", 
    tickprefix = "", 
    ticks = "", 
    ticksuffix = "", 
    title = "Venda (R$)", 
    titlefont = list(
      color = "#444", 
      family = "\"Open Sans\", verdana, arial, sans-serif", 
      size = 14
    ), 
    type = "linear", 
    zeroline = TRUE, 
    zerolinecolor = "#444", 
    zerolinewidth = 1
  )
)
p <- plot_ly()
p <- add_trace(p, x=trace1$x, y=trace1$y, connectgaps=trace1$connectgaps, line=trace1$line, marker=trace1$marker, mode=trace1$mode, name=trace1$name, showlegend=trace1$showlegend, type=trace1$type, uid=trace1$uid, xsrc=trace1$xsrc, ysrc=trace1$ysrc)
p <- add_trace(p, x=trace2$x, y=trace2$y, line=trace2$line, marker=trace2$marker, mode=trace2$mode, name=trace2$name, type=trace2$type, uid=trace2$uid, xsrc=trace2$xsrc, ysrc=trace2$ysrc)
p <- add_trace(p, x=trace3$x, y=trace3$y, line=trace3$line, mode=trace3$mode, name=trace3$name, type=trace3$type, uid=trace3$uid, xsrc=trace3$xsrc, ysrc=trace3$ysrc)
p <- add_trace(p, x=trace4$x, y=trace4$y, line=trace4$line, mode=trace4$mode, name=trace4$name, type=trace4$type, uid=trace4$uid, xsrc=trace4$xsrc, ysrc=trace4$ysrc)
p <- add_trace(p, x=trace5$x, y=trace5$y, line=trace5$line, mode=trace5$mode, name=trace5$name, type=trace5$type, uid=trace5$uid, xsrc=trace5$xsrc, ysrc=trace5$ysrc)
p <- add_trace(p, x=trace6$x, y=trace6$y, line=trace6$line, mode=trace6$mode, name=trace6$name, type=trace6$type, uid=trace6$uid, xsrc=trace6$xsrc, ysrc=trace6$ysrc)
p <- layout(p, autosize=layout$autosize, dragmode=layout$dragmode, hidesources=layout$hidesources, hovermode=layout$hovermode, legend=layout$legend, paper_bgcolor=layout$paper_bgcolor, plot_bgcolor=layout$plot_bgcolor, separators=layout$separators, showlegend=layout$showlegend, smith=layout$smith, title=layout$title, xaxis=layout$xaxis, yaxis=layout$yaxis)
p