require("bnlearn")

setwd("~/Documents/projetos/data-science/inferenciaBayesiana/coronary")

#Coleta da Base de Dados Coronary
coronaryDataFrame <- data.frame(coronary)

#Aprendizagem da rede bayesiana usando algoritmo Hill-Climbing (HC)
res <- hc(coronaryDataFrame)
res <- drop.arc(res, "M..Work", "Family")

#Plot da Rede
plot(res)


#Rede Bayesiana Ajustada
bnAjustado <- bn.fit(res, data = coronaryDataFrame)

print(bnAjustado$Proteins)