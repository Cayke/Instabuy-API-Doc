---
title: Instabuy Linear API Doc

language_tabs: # must be one of https://git.io/vQNgJ
- shell
#   - json
  # - shell
  # - ruby
  # - python
  # - javascript

toc_footers:
  - <a href='https://www.instabuy.com.br'>Build with Love by Instabuy</a>

includes:
  # - kittens
  # - errors

search: true
---

# Introduction

Welcome to Instabuy's **Linear Sistemas** API. This API allows you to provide update products, get buys and set buy invoice.

## URLs

For development purpose you should use [http://dev.api.instabuy.com.br/linear](http://dev.api.instabuy.com.br/linear).

For production purpose you should use [https://api.instabuy.com.br/linear](https://api.instabuy.com.br/linear).

## Request/Response Format

Requests with a message-body should send a **XML** string to set or update resource attributes. Successful requests will return a `200 OK` HTTP status.


# Authentication

The Authentication in Instabuy's API is made using **API KEY**. In every request, you should send the store API KEY in the request `headers` using the key `api-key`. To get store API KEY please check store admin interface or contact Instabuy Team.

# Products
This API allow you to update products prices. You should pass `store cnpj` in the url and the XML as a string in the request body.
The XML fields are the same as defined in Linear Official Documentation.

```shell
curl -X POST \
  https://api.instabuy.com.br/linear/products/cnpj/123456 \
  -H 'Content-Type: text/xml' \
  -H 'Host: api.instabuy.com.br' \
  -H 'api-key: ed9521d2-7f44-4c9e-949c-c5e0ce664a96' \
  -d '<?xml version="1.0" encoding="Windows-1252"?>
<Importacao>
   <Produto>
      <Descricao_Web> <![CDATA[BISCOITO MARILAN AMANTEIGADO MILHO VERDE 400G]]></Descricao_Web>
      <Descricao_Sistema> <![CDATA[BISC.AMANTEIGADO MARILAN 400GR M. VERDE]]></Descricao_Sistema>
      <cod_produto>000415-4</cod_produto>
      <EAN13>7896003703535</EAN13>
      <Informacoes_Produto> <![CDATA[Ingredientes:

      Farinha de trigo fortificada com ferro e ácido fólico, açúcar, gordura vegetal, creme de milho, soro 
      de leite em pó, ovo integral desidratado, sal, manteiga, aromatizante, estabilizante lecitina de 
      soja, fermentos químicos (bicarbonato de sódio e bicarbonato de amônio) e acidulante ácido 
      láctico. Conservar em local seco e fresco.

      CONTÉM GLÚTEN.]]></Informacoes_Produto>
      <Estoque_Disponivel>785</Estoque_Disponivel>
      <Estoque_Seguranca>123</Estoque_Seguranca>
      <Depto_Web> <![CDATA[BISCOITOS E CHOCOLATES]]></Depto_Web>
      <Secao_Web> <![CDATA[BISCOITO DOCE]]></Secao_Web>
      <Categoria_Web> <![CDATA[]]></Categoria_Web>
      <Subcategoria_Web> <![CDATA[]]></Subcategoria_Web>
      <Unidade_Medida>UN</Unidade_Medida>
      <Tabela_Nutricional>
         <Porcao>50</Porcao>
         <Unid_Porcao>G</Unid_Porcao>    
         <Vl_Calorico>176</Vl_Calorico>
         <Carboidratos>38</Carboidratos>
         <Proteinas>5</Proteinas>
         <Gord_Total>.7</Gord_Total>
         <Gord_Sat></Gord_Sat>
         <Colesterol></Colesterol>
         <Fibra>1.4</Fibra>
         <Calcio></Calcio>
         <Ferro>2.1</Ferro>
         <Sodio>137</Sodio>
         <Gord_Trans></Gord_Trans>
         <Vl_CaloricoVD>10</Vl_CaloricoVD>
         <CarboidratosVD>8</CarboidratosVD>
         <ProteinasVD>5</ProteinasVD>
         <Gord_TotalVD>7</Gord_TotalVD>
         <Gord_SatVD></Gord_SatVD>
         <ColesterolVD></ColesterolVD>
         <FibraVD>4</FibraVD>
         <CalcioVD></CalcioVD>
         <FerroVD>1</FerroVD>
         <SodioVD>13</SodioVD>
         <Gord_TransVD>1</Gord_TransVD>
      </Tabela_Nutricional>
      <Preco_Web>3.49</Preco_Web>
      <Preco_Custo>1.89</Preco_Custo>

      <Situacao_Web>D</Situacao_Web> 
      <Codigo_Embalagem></Codigo_Embalagem>
      <Qtde_Embalagem></Qtde_Embalagem>
      <Pesavel>N</Pesavel>
      <Modulo></Modulo>
      <Rua></Rua>
      <Numero></Numero>
      <Apartamento></Apartamento>
      <Ultima_Alteracao>10-JAN-12</Ultima_Alteracao>
   </Produto>
   <Produto>
      <Descricao_Web> <![CDATA[BISCOITO MARILAN AMANTEIGADO MILHO VERDE 400G]]></Descricao_Web>
      <!-- Não utilizado -->
      <Descricao_Sistema> <![CDATA[BISC.AMANTEIGADO MARILAN 400GR M. VERDE]]></Descricao_Sistema>
      <cod_produto>31993</cod_produto>
      <EAN13>7896003703535</EAN13>
      <Informacoes_Produto> <![CDATA[Ingredientes:

      Farinha de trigo fortificada com ferro e ácido fólico, açúcar, gordura vegetal, creme de milho, soro 
      de leite em pó, ovo integral desidratado, sal, manteiga, aromatizante, estabilizante lecitina de 
      soja, fermentos químicos (bicarbonato de sódio e bicarbonato de amônio) e acidulante ácido 
      láctico. Conservar em local seco e fresco.

      CONTÉM GLÚTEN.]]></Informacoes_Produto>
      <Estoque_Disponivel>785</Estoque_Disponivel>
      <Estoque_Seguranca>123</Estoque_Seguranca>
      <Depto_Web> <![CDATA[BISCOITOS E CHOCOLATES]]></Depto_Web>
      <Secao_Web> <![CDATA[BISCOITO DOCE]]></Secao_Web>
      <Categoria_Web> <![CDATA[]]></Categoria_Web>
      <Subcategoria_Web> <![CDATA[]]></Subcategoria_Web>
      <Unidade_Medida>UN</Unidade_Medida>
      <Tabela_Nutricional>
         <Porcao>50</Porcao>
         <Unid_Porcao>G</Unid_Porcao>    
         <Vl_Calorico>176</Vl_Calorico>
         <Carboidratos>38</Carboidratos>
         <Proteinas>5</Proteinas>
         <Gord_Total>.7</Gord_Total>
         <Gord_Sat></Gord_Sat>
         <Colesterol></Colesterol>
         <Fibra>1.4</Fibra>
         <Calcio></Calcio>
         <Ferro>2.1</Ferro>
         <Sodio>137</Sodio>
         <Gord_Trans></Gord_Trans>
         <Vl_CaloricoVD>10</Vl_CaloricoVD>
         <CarboidratosVD>8</CarboidratosVD>
         <ProteinasVD>5</ProteinasVD>
         <Gord_TotalVD>7</Gord_TotalVD>
         <Gord_SatVD></Gord_SatVD>
         <ColesterolVD></ColesterolVD>
         <FibraVD>4</FibraVD>
         <CalcioVD></CalcioVD>
         <FerroVD>1</FerroVD>
         <SodioVD>13</SodioVD>
         <Gord_TransVD>1</Gord_TransVD>
      </Tabela_Nutricional>
      <Preco_Web>3.49</Preco_Web>
      <!-- Não utilizado -->
      <Preco_Custo>1.89</Preco_Custo>
      <Situacao_Web>I</Situacao_Web> 
      <Codigo_Embalagem></Codigo_Embalagem>
      <Qtde_Embalagem></Qtde_Embalagem>
      <Pesavel>N</Pesavel>
      <Modulo></Modulo>
      <Rua></Rua>
      <Numero></Numero>
      <Apartamento></Apartamento>
      <!-- Não utilizado -->
      <Ultima_Alteracao>10-JAN-12</Ultima_Alteracao>
   </Produto>
</Importacao>'
```

> JSON response example:

```json
{
    "data": {
        "status": "success",
        "count": 2,
        "updated": 0,
        "registered": 1
    },
    "status": "success",
    "count": 0,
    "http_status": 200
}
```

### HTTP Request
`POST /products/cnpj/{{store_cnpj}}`


# Buys
This API allow you to get buys that have no invoice issued yet and set invoice to them. You should pass `store cnpj` in the url.

## Get Buy with invoice pending
The response returns a XML string containing a buy with pending invoice. The XML fields are the same as defined in Linear Official Documentation.

```shell
curl -X GET \
  https://api.instabuy.com.br/linear/orders-pending/cnpj/123456 \
  -H 'Content-Type: text/xml' \
  -H 'Host: api.instabuy.com.br' \
  -H 'api-key: ed9521d2-7f44-4c9e-949c-c5e0ce664a96' \
```

> XML response example:

```xml
<?xml version="1.0" encoding="windows-1252"?>
<DADOS>
    <DADOSCLIENTE>
        <email>cayke10@gmail.com</email>
        <razao_social>Cayke Prudente</razao_social>
        <data_cad>02-27-2016</data_cad>
        <tipo_pessoa>F</tipo_pessoa>
        <cpf_cnpj>03487548124</cpf_cnpj>
        <sexo>M</sexo>
        <endereco>Condomínio Residencial Mansões Itaipu</endereco>
        <bairro>Setor Habitacional Jardim Botânico (Lago Sul)</bairro>
        <CEP>71680-373</CEP>
        <cidade>Brasília</cidade>
        <numero>10</numero>
        <Uf>DF</Uf>
    </DADOSCLIENTE>
    <DADOSPEDIDO>
        <num_ped_web>231769</num_ped_web>
        <data_ped_web>05-20-2019</data_ped_web>
        <hora_ped_web>23:08:26</hora_ped_web>
        <total_ped_web>75.42</total_ped_web>
        <desc_total_ped_web>0.0</desc_total_ped_web>
        <valor_frete>10.0</valor_frete>
        <data_entrega>05-26-2019</data_entrega>
        <observacao>teste linear</observacao>
        <produto>
            <codigo>040364</codigo>
            <quantidade>3.0</quantidade>
            <embalagem>3.0</embalagem>
            <unid_medida>UN</unid_medida>
            <valor_unit>15.99</valor_unit>
            <total_item>47.97</total_item>
        </produto>
        <produto>
            <codigo>000415</codigo>
            <quantidade>5.0</quantidade>
            <embalagem>5.0</embalagem>
            <unid_medida>KG</unid_medida>
            <valor_unit>3.49</valor_unit>
            <total_item>17.45</total_item>
        </produto>
    </DADOSPEDIDO>
</DADOS>
```

### HTTP Request
`GET /orders-pending/cnpj/{{store_cnpj}}`


## Set invoice to buy
You should pass the XML as a string in the request body. The XML fields are the same as defined in Linear Official Documentation.

```shell
curl -X PUT \
  https://api.instabuy.com.br/linear/orders-pending/cnpj/123456 \
  -H 'Content-Type: text/xml' \
  -H 'Host: api.instabuy.com.br' \
  -H 'api-key: ed9521d2-7f44-4c9e-949c-c5e0ce664a96' \
  -d '<?xml version="1.0" encoding="Windows-1252"?>
<Dados>
    <Retorno>
        <Numero_Pedido>1000001</Numero_Pedido>
        <Numero_Pedido_VIP>231769</Numero_Pedido_VIP>
        <Data_Emissao>14-SEP-13</Data_Emissao>
        <Numero_Cupom>3506722</Numero_Cupom>
        <Numero_Nota>3506722</Numero_Nota>
        <Operador>Nome do operador</Operador>
    </Retorno>
</Dados>'
```

> JSON response example:

```json
{
    "data": "ok",
    "status": "success",
    "count": 0,
    "http_status": 200
}
```

### HTTP Request
`PUT /orders-pending/cnpj/{{store_cnpj}}`
