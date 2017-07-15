SELECT CAST(YEAR(dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01' AS mes,
      sum(quantidade * vlrUnitario) AS venda
FROM Movimentacao with (nolock)
WHERE (
CAST(YEAR(dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01' BETWEEN '2010-01-01' AND '2017-12-01')
 and codLoja = 15
GROUP BY 
CAST(YEAR(dtaMovimentacao) AS VARCHAR(4)) + '-' +  right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01'
order by mes

select top 10 * from Movimentacao where codFranqueador = 37