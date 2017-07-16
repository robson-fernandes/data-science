--FUNÇÃO - RETORNAR QUANTIDADE
ALTER FUNCTION getQuantidadeVendidaGrupo(
@codFranqueador int,
@codLoja int,
@dataInicial date,
@dataFinal date,
@codGrupoVenda int,
@mesRef varchar(30))
RETURNS int
BEGIN
   DECLARE @retorno int
   
   set @retorno =  (
   select 
	sum (m.quantidade)  as quantidadeProduto
	FROM Movimentacao m WITH(NOLOCK)
	INNER JOIN Produto p  WITH(NOLOCK) ON  p.codFranqueador = m.codFranqueador AND p.codProduto = m.codProduto
	INNER JOIN TipoVenda tp  WITH(NOLOCK) ON tp.codTipoVenda = m.codTipoVenda AND tp.codFranqueador = m.codFranqueador
	INNER JOIN GrupoVenda gv WITH(NOLOCK) ON p.codGrupoVenda = gv.codGrupoVenda and p.codFranqueador = gv.codFranqueador

	WHERE 
		p.Ativo = 'S' 
		AND gv.Ativo = 'S' 
		AND m.codFranqueador = @codFranqueador
		AND m.codLoja = @codLoja
		and vlrUnitario > 0
		and gv.codGrupoVenda = @codGrupoVenda
		AND 
		CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01'  = @mesRef
	group by
	CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01' 
	)

   RETURN(COALESCE(@retorno,0))
END


/**
codGrupoVenda	desGrupoVenda
21	BRINDE                        
19	BEX DOCES                     
18	LANCHE FRANQUEADO             
17	BEX SALADAS                   
16	BEX CAFE                      
15	BEX SNACKS                    
14	BEX BEBIDAS                   
13	BEX SANDUICHES E MOLHOS       
12	BEX GELADOS E MILKSHAKES      
11	OUTROS                        
10	PROJETO CAFÉ                  
9	PROJETO CHOPP                 
8	LINHA ORIGINAL                
7	ADICIONAL                     
5	PRATO                         
4	ACOMPANHAMENTO                
3	SANDUICHE                     
2	GELADO E MILK SHAKE           
1	BEBIDA                        
25	CALDA BOBS TOP                
29	REFEICAO COLABORADORES        
24	ITENS DE COMPOSIÇÃO           
*/


SET LANGUAGE english

DECLARE @codFranqueador int
DECLARE @codLoja int
DECLARE @anoRef int

DECLARE @dataInicial date
DECLARE @dataFinal date

set @anoRef = 2010
set @codFranqueador = 37
set @codLoja = 15


set @dataInicial = '2010-01-01'
set @dataFinal = '2017-12-31'
	

select 

CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01' AS mes
  ,sum (m.quantidade) as quantidadeProduto
  ,dbo.getQuantidadeVendidaGrupo(
  @codFranqueador,@codLoja, @dataInicial, @dataFinal, 4, --'ACOMPANHAMENTO'
  CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01'
  ) as grupoAcompanhamento
  ,dbo.getQuantidadeVendidaGrupo(
  @codFranqueador,@codLoja, @dataInicial, @dataFinal, 1, --'BEBIDA' 
  CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01'
  ) as grupoBebida  
  , dbo.getQuantidadeVendidaGrupo(
  @codFranqueador,@codLoja, @dataInicial, @dataFinal, 3, --'SANDUICHE'
  CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01'
  ) as grupoSanduiche 
  ,dbo.getQuantidadeVendidaGrupo(
  @codFranqueador,@codLoja, @dataInicial, @dataFinal, 2, --'GELADO E MILK SHAKE'
  CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01'
  ) as grupoMilkShake 
  ,dbo.getQuantidadeVendidaGrupo(
  @codFranqueador,@codLoja, @dataInicial, @dataFinal, 5, --'Prato'
  CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01'
  ) as grupoPrato
    ,dbo.getQuantidadeVendidaGrupo(
  @codFranqueador,@codLoja, @dataInicial, @dataFinal, 7, --'Adicional'
  CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01'
  ) as grupoAdicional
    ,dbo.getQuantidadeVendidaGrupo(
  @codFranqueador,@codLoja, @dataInicial, @dataFinal, 21, --'Brinde'
  CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01'
  ) as grupoBrinde
   ,dbo.getQuantidadeVendidaGrupo(
  @codFranqueador,@codLoja, @dataInicial, @dataFinal, 24, --'ItensComposicao'
  CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01'
  ) as grupoItensComposicao
FROM Movimentacao m WITH(NOLOCK)
INNER JOIN Produto p  WITH(NOLOCK) ON  p.codFranqueador = m.codFranqueador AND p.codProduto = m.codProduto
INNER JOIN TipoVenda tp  WITH(NOLOCK) ON tp.codTipoVenda = m.codTipoVenda AND tp.codFranqueador = m.codFranqueador
INNER JOIN GrupoVenda gv WITH(NOLOCK) ON p.codGrupoVenda = gv.codGrupoVenda and p.codFranqueador = gv.codFranqueador

WHERE 
    p.Ativo = 'S' 
    AND gv.Ativo = 'S' 
	AND m.codFranqueador = @codFranqueador
	AND m.codLoja = @codLoja
	and vlrUnitario > 0
	and m.dtaMovimentacao BETWEEN @dataInicial AND @dataFinal
	
group by
CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01' 
order by 
CAST(YEAR(m.dtaMovimentacao) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(dtaMovimentacao) AS VARCHAR(2)),2) + '-' + '01'