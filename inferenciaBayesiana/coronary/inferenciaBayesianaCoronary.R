require("bnlearn")

#Coleta da Base de Dados Coronary
coronaryDataFrame <- data.frame(coronary)

#Aprendizagem da rede bayesiana usando algoritmo Hill-Climbing (HC)
res <- hc(coronaryDataFrame)
#Plot da Rede
plot(res)

#Remover o Link entre nós "M..Work", "Family"
res <- drop.arc(res, "M..Work", "Family")
#Plot da Rede
plot(res)

#Rede Bayesiana Ajustada
bnAjustado <- bn.fit(res, data = coronaryDataFrame)

#Tabela de Probabilidade Condicional - Pressure
print(bnAjustado$Pressure)

#Inferência em Redes Bayesianas
cpquery(bnAjustado, 
        event = (Proteins=="<3"), 
        evidence = ( Smoking=="no" & Pressure==">140" ) )




