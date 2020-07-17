---
title: Instabuy Tetra Soluções API Doc

language_tabs: # must be one of https://git.io/vQNgJ
#   - json
  - shell
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

Welcome to Instabuy's **REST** Tetra API. This API allows you to update products and get orders.

To check other docs, click above:

- [Client API Doc](/).

## URLs

<!-- For development purpose you should use [http://dev.api.instabuy.com.br/api_raffle](http://dev.api.instabuy.com.br/api_raffle). -->

For production purpose you should use [https://api.instabuy.com.br/api_tetra](https://api.instabuy.com.br/api_tetra).

## Request/Response Format

The default response format is **JSON**. Requests with a message-body use plain JSON to set or update resource attributes. Successful requests will return a `200 OK` HTTP status.

Some general information about responses:

- Dates are returned in ISO8601 format: `YYYY-MM-DDTHH:MM:SS`
- Any decimal monetary amount, such as prices or totals, will be returned as numbers with two decimal places.
- Other amounts, such as item counts, are returned as integers.
- Blank/Null fields are generally omitted.

### Response Format

All server's response have 4 fields in it: `status`, `data`, `count`, `http_status`.

#### Status

The status fields returns either `"sucess"` or `"error"`. Success is send when the operation made by the request went well all the way. Error is passed when the expected result was not reached during the process.

#### Data

The info itself. Here it could be an error message, if status is error, or list, object, string, etc if status is success.

#### Count

The number of objects the query should return if no pagination/filter were applied.

#### HTTP Status

The response's HTTP Status.

## Errors
Occasionally you might encounter errors when accessing the REST API. Below are the possible types:

Error Code | Error Type
-------------- | --------------
`211 Unauthorized` | You are trying to access a protected endpoint but dont have permission / aren't logged.
`212 User Blocked` | You were blocked from the system.
`213 Not Found` | Query didn't return results.
`214 Expected Error` | Expected Error, e.g.: system could not save item because slug is not unique.
`218 Reload Cart` | One or more items on the user's cart had stock or price changed, please get cart again.
`400 Bad Request` | Invalid request, e.g. using an unsupported HTTP method
`404 Not Found` | Requests to resources that don't exist or are missing
`405 Method Not Allowed` | You tried to access a endpoint with an invalid method.
`500 Internal Server Error` | Server error


## Pagination
Requests that return multiple items will be paginated to 12/25 items by default. This default can be changed specifing the `?N` parameter:

`GET /buys?N=15`

You can specify further pages with the `?page` parameter:

`GET /buys?page=2`

You can use both parameters as well:

`GET /buys?page=5&N=15`

Page number is `1-based` and omitting the `?page` parameter will return the first page.

The total number of resources are included in the response `count` field.


## Images
All fields that represent images have only the image Identifier and not the image URL.
<!-- todo -->

# Authentication

The Authentication in Instabuy's API is made using **API-KEY**. Therefore, to access all endpoints you must pass the API_KEY in the request header as a `api-token` field. Please contact Instabuy's team to get your API-KEY.



# Products
This API allows you to update products info.

## Product properties
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`plu` | string | required | Unique identifier for the product.
`visible` | bool | required | If product should be visible/active in e-commerce.
`price` | float | required | Product regular price.
`stock` | float | required | Product stock.
`name` | string | required | Product name.
`barcodes` | array - [string] | optional | List with barcodes.
`promo_price` | float | optional | 	Product promotional price.
`promo_start_at` | string | optional | Product promotional price start date. `YYYY-MM-DD` format.
`promo_end_at` | string | optional | Product promotional price end date. `YYYY-MM-DD` format.


## Update Products
This API allows you to update products.

```shell
curl -X POST \
  https://api.instabuy.com.br/api_tetra/products/cnpj/23406149000170 \
  -H 'api-token: 18aaab24-581b-4e1d-9a44-e876cb4cea22' \
  -d '{
	"products": [
		{
			"name": "Vinho 1",
			"plu": "300",
			"price": 27,
			"visible": true,
			"stock": 47,
			"barcodes": ["123456"]
		},
		{
			"name": "Vinho 3",
			"plu": "500",
			"price": 10,
			"visible": true,
			"stock": 20,
			"promo_price": 8.90,
			"promo_start_at": "2019-12-10",
			"promo_end_at": "2019-12-31"
		}
	]
}'
```

> JSON response example:

```json
{
    "data": {
        "status": "success",
        "count": 2,
        "updated": 1,
        "registered": 2
    },
    "status": "success",
    "count": 0,
    "http_status": 200
}
```

### HTTP Request
`POST /products/cnpj/<store_cnpj>`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`products` | array | required | List of [Products](#product-properties).



# Buy
This API allows you to list buys.

## Buy properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`created_at` | datetime | The date the resource was created.
`code` | string | Buy code.
`subtotal` | float | Buy subtotal.
`discount` | float | Buy discount.
`delivery_tax` | float | Buy delivery tax.
`total` | float | Buy total.
`status_history` | Array | List of status history. See [Status History](#buy-status-history-properties).
`status` | string | Buy actual status.
`schedule` | boolean | If buy have scheduled delivery hour.
`delivery_hour` | object | See [Delivery Hour](#buy-delivery-hour-properties).
`billet_percent_discount` | float | Discount that should be applied to buy subtotal.
`kits` | array | List of Kits. See [Kit](#buy-kit-properties).
`payment_info` | object | See [Payment Info](#buy-payment-info-properties).
`delivery_info` | object | See [Address](#address-properties).
`comment` | string | Client buy comment.
`products` | array | List of Products. See[Product](#buy-product-properties).
`installments` | string | See [Installment](#buy-installment-properties).

## Buy - Status History properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`created_at` | datetime | The date the resource was created.
`message` | string | Message.
`old_status` | string | Old status.
`new_status` | string | New status.

## Buy - Delivery Hour properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`delivery_date` | datetime | The date the resource was created.
`start_time` | string | Message.
`end_time` | string | Old status.

## Buy - Payment Info properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`method` | string | Payment method.
`value` | string | Payment value.

## Buy - Product properties
Attribute | Type | Description
-------------- | -------------- | --------------
`id` | string |	Unique identifier for the resource. 
`bar_codes` | array | List of barcodes.
`price` | float | Product unitary price.
`qtd` | float | Product quantity.
`unit_type` | string | Product unit type.
`model_internal_code` | string | Product price internal code.
`model_id` | string | Product price Id.
`image` | string | Product image key.
`model_title` | string | Product price title.
`name` | string | Product name.

## Buy - Kit properties
Attribute | Type | Description
-------------- | -------------- | --------------
`id` | string |	Unique identifier for the resource. 
`model_internal_code` | string | Product price internal code.
`price` | float | Product unitary price.
`qtd` | float | Product quantity.
`image` | string | Product image key.
`name` | string | Product name.
`bundles` | array | List of bundles. See [Kit Bundle](#buy-kit-bundle-properties).

## Buy - Kit Bundle properties
Attribute | Type | Description
-------------- | -------------- | --------------
`id` | string |	Unique identifier for the resource. 
`products` | array | List of bundle products. See [Kit Bundle Product](#buy-kit-bundle-product-properties).

## Buy - Kit Bundle Product properties
Attribute | Type | Description
-------------- | -------------- | --------------
`id` | string |	Unique identifier for the resource. 
`qtd` | float | Product quantity.
`name` | string | Product name.

## Buy Installment properties
Attribute | Type | Description
-------------- | -------------- | --------------
`installments_number` | int | Instalmments number.
`buy_min_value` | float | Min buy value to allow this installment.
`interest` | float | Interest per installment.

## Buy Status properties
Status | Description
-------------- | -------------- | --------------
`ib_wait_auth`        | compra esperando autorizacao do lojista
`ib_confirmed`        | compra foi confirmada pela loja
`ib_canceled`         | compra foi cancelada
`ib_fraud_suspect`    | compra está com suspeita de fraude
`ib_store_processing` | compra está sendo processada pela loja
`ib_ready`            | compra está pronta, produtos ja foram reparados
`ib_invoice_issued`   | nota/cupom fiscal emitida
`ib_on_the_way`       | compra está há caminho do usuário
`ib_waiting_client`   | compra está esperando o cliente
`ib_paid` 			  |  compra paga diretamente ao lojista
`ib_trial`            | assinatura está em trial
`ib_closed`           | compra foi finalizada. OBS: compra precisa passar por `ib_paid` ou `pm_paid` para poder ser finalizada.
`pm_expired`          | assinatura passou da data de pagamento e nao houve pagamento efetuado
`pm_processing`       | transação sendo processada.
`pm_authorized`       | transação autorizada. Cliente possui saldo na conta e este valor foi reservado para futura captura, que deve 						acontecer em no máximo 5 dias. Caso a transação não seja capturada, a autorização é cancelada automaticamente.
`pm_paid`             | transação paga (autorizada e capturada).
`pm_refunded`         | transação estornada.
`pm_waiting_payment`  | transação aguardando pagamento (status para transações criadas com boleto bancário).
`pm_pending_refund`   | transação paga com boleto aguardando para ser estornada.
`pm_refused`          | transação não autorizada.
`pm_chargedback`      | transação sofreu chargeback.
`pm_canceled`         | transação cancelada.
`cs_approved`         | transacao liberada pela clearsale
`cs_reproved`         | transacao reprovada pela clearsale
`cs_waiting`          | aguardando analise da clearsale

## Retrieve Buys
This API allows you to get buys.

```shell
curl -X GET \
  http://localhost:8000/api_tetra/orders-pending/cnpj/23406149000170 \
  -H 'api-token: 18aaab24-581b-4e1d-9a44-e876cb4cea22' \
```

> JSON response example:

```json
{
    "data": [
        {
            "client_ip": "164.41.42.18",
            "created_at": "2019-11-01T20:25:10.608000+00:00",
            "client": "5ce4323d6b8fbe43963e2427",
            "status": "ib_ready",
            "status_history": [
                {
                    "author": "cayke@teste.com",
                    "created_at": "2019-11-06T23:39:23.628000+00:00",
                    "old_status": "ib_wait_auth",
                    "new_status": "ib_store_processing",
                    "message": "Alteração de status: Esperando Autorização -> Processando"
                },
                {
                    "author": "cayke10@gmail.com",
                    "created_at": "2019-12-11T19:17:30.281000+00:00",
                    "old_status": "ib_store_processing",
                    "new_status": "ib_ready",
                    "message": "Alteração de status: Processando -> Produtos separados"
                }
            ],
            "seen": true,
            "delivery_tax": 15.0,
            "should_replace_missing_products": false,
            "buy_type": "deli",
            "id": "5dbc94a66beb9440d5acd000",
            "kits": [],
            "store_id": "55c17d73072d4126ea180fe5",
            "payment_info": {
                "method": "cash",
                "value": "50.0"
            },
            "creator": "unknown",
            "platform": "ib_web",
            "code": "8WKC-30D0",
            "last_modified": "2019-12-11T19:17:30.311000+00:00",
            "comment": "Compra Teste",
            "device": "Unknown;Mac;Chrome",
            "schedule": true,
            "billet_percent_discount": 0.0,
            "products": [
                {
                    "name": "Açai ",
                    "image": "1dacc25581a14997ae40a39645cfaaa0.jpeg",
                    "unit_type": "UNI",
                    "qtd": 2.0,
                    "id": "5cec1b4678a584c4645934ee",
                    "model_id": "74e22366ec5f4b85",
                    "model_title": "default",
                    "model_internal_code": "fdd9f00a92",
                    "bar_codes": [],
                    "subcategory": "5cec1b66548656f0e85939ab",
                    "price": 12.0
                }
            ],
            "delivery_hour": {
                "delivery_date": "2019-11-05T13:00:00+00:00",
                "end_time": "17:30",
                "start_time": "13:00",
                "id": "c88ed"
            },
            "separator_email": "cayke@teste.com",
            "delivery_info": {
                "country": "Brasil",
                "zipcode": "70687-305",
                "state": "DF",
                "city": "Brasília",
                "neighborhood": "Setor Noroeste",
                "street_number": "02",
                "complement": "",
                "street": "Quadra SQNW 311 Bloco A"
            },
            "online_payment_transaction_info": {},
            "subtotal": 24.0,
            "discount": 0.0,
            "total": 39.0
        }
    ],
    "status": "success",
    "count": 1,
    "http_status": 200
}
```

### HTTP Request
`GET /orders-pending/cnpj/<store-cnpj>`

## Retrieve especific buy
This API allows you to get a buy with Id.

```shell
curl -X GET \
  http://localhost:8000/api_tetra/order/cnpj/23406149000170/order_id/5e0a35bf25d2b20f17e93276 \
  -H 'api-token: 18aaab24-581b-4e1d-9a44-e876cb4cea22' \
```

> JSON response example:

```json
{
    "data": {
        "online_payment_transaction_info": {},
        "last_modified": "2019-12-30T18:06:15.638000+00:00",
        "status": "ib_invoice_issued",
        "client_ip": "181.221.64.40",
        "status_history": [
            {
                "created_at": "2019-12-30T17:38:02.164000+00:00",
                "message": "Alteração de status: Esperando Autorização -> Produtos separados",
                "new_status": "ib_ready",
                "author": "correasanderson@gmail.com",
                "old_status": "ib_wait_auth"
            },
            {
                "created_at": "2019-12-30T18:06:15.634000+00:00",
                "message": "Alteração de status: Produtos separados -> Nota fiscal emitida",
                "new_status": "ib_invoice_issued",
                "author": "tetra",
                "old_status": "ib_ready"
            }
        ],
        "client": {	
            "last_modified": "2019-12-30T17:36:21.972000+00:00",
            "email": "flusanderson@gmail.com",
            "card_errors_count": 0,
            "gender": "M",
            "birthday": "1995-05-18T12:00:00+00:00",
            "first_name": "Sanderson",
            "cpf": "149.797.597-26",
            "phone": "(22) 99977-6131",
            "created_at": "2019-12-30T13:07:29.710000+00:00",
            "last_name": "Corrêa",
            "id": "5e09f6913b68981ab725e86b",
            "user_type": "PF"
        },
        "should_replace_missing_products": false,
        "creator": "unknown",
        "platform": "ib_web",
        "payment_info": {
            "value": "MasterCard",
            "method": "credit"
        },
        "device": "Unknown;Windows;Chrome",
        "created_at": "2019-12-30T17:37:03.670000+00:00",
        "store_id": "5dfccf3c3006aa81b4f242e2",
        "id": "5e0a35bf25d2b20f17e93276",
        "kits": [],
        "comment": "Trazer canudos",
        "buy_type": "deli",
        "seen": true,
        "delivery_info": {
            "zipcode": "28085-210",
            "country": "Brasil",
            "complement": "Casa - Rua do Arantes",
            "street": "Rua Atanagildo de Freitas",
            "neighborhood": "Parque Bandeirantes",
            "street_number": "117",
            "city": "Campos dos Goytacazes",
            "state": "RJ"
        },
        "billet_percent_discount": 0.0,
        "products": [
            {
                "model_title": "Garrada",
                "name": "Coca-Cola 600ml",
                "image": "b6deccb4a9ae466a8714189ec7926589.jpeg",
                "price": 29.0,
                "qtd": 5.0,
                "bar_codes": [
                    "1234"
                ],
                "model_internal_code": "4321",
                "subcategory": "5dfcd8822555d82f215df2a1",
                "model_id": "8dc2cfa17b4943a7",
                "attachment": "Gelada",
                "id": "5dfd296ccb07f97d176bda23",
                "unit_type": "UNI"
            }
        ],
        "delivery_tax": 10.0,
        "delivery_hour": {
            "end_time": "18:00",
            "start_time": "14:00",
            "id": "tv27e2aD",
            "delivery_date": "2019-12-31T14:00:00+00:00"
        },
        "schedule": true,
        "code": "7C4X-Y3G8",
        "subtotal": 145.0,
        "discount": 0.0,
        "total": 155.0
    },
    "status": "success",
    "count": 1,
    "http_status": 200
}
```

### HTTP Request
`GET /order/cnpj/<store-cnpj>/order_id/<order-id>`

## Edit Buy Status
This API allows you to edit a buy status.

```shell
curl --location --request PUT 'localhost:8000/api_tetra/order/cnpj/12048636000192/order_id/5e2ae114cc97ec5dbd1855d3?status=ib_closed' \
--header 'api-token: 18aaab24-581b-4e1d-9a44-e876cb4cea22'
```

> JSON response example:

```json
{
    "data": {
        "id": "5e2ae114cc97ec5dbd1855d3",
        "status_history": [
            {
                "created_at": "2020-01-24T12:22:17.167000+00:00",
                "author": "correasanderson@gmail.com",
                "new_status": "ib_ready",
                "old_status": "ib_wait_auth",
                "message": "Alteração de status: Esperando Autorização -> Produtos separados"
            },
            {
                "created_at": "2020-01-24T12:22:43.114000+00:00",
                "author": "tetra",
                "new_status": "ib_invoice_issued",
                "old_status": "ib_ready",
                "message": "Alteração de status: Produtos separados -> Nota fiscal emitida"
            },
            {
                "created_at": "2020-01-24T18:45:35.254000+00:00",
                "author": "tetra",
                "new_status": "ib_paid",
                "old_status": "ib_invoice_issued",
                "message": "Alteração de status: Nota fiscal emitida -> Pago ao lojista"
            },
            {
                "created_at": "2020-01-24T18:45:47.465000+00:00",
                "author": "tetra",
                "new_status": "ib_closed",
                "old_status": "ib_paid",
                "message": "Alteração de status: Pago ao lojista -> Finalizado"
            }
        ],
        "billet_percent_discount": 0.0,
        "payment_info": {
            "method": "credit",
            "value": "Visa"
        },
        "creator": "unknown",
        "online_payment_transaction_info": {},
        "buy_type": "deli",
        "client": {
            "id": "5e09f6913b68981ab725e86b",
            "first_name": "Sanderson",
            "phone": "(22) 99977-6131",
            "created_at": "2019-12-30T13:07:29.710000+00:00",
            "gender": "M",
            "birthday": "1995-05-18T12:00:00+00:00",
            "last_modified": "2019-12-30T17:36:21.972000+00:00",
            "card_errors_count": 0,
            "user_type": "PF",
            "email": "flusanderson@gmail.com",
            "last_name": "Corrêa",
            "cpf": "149.797.597-26"
        },
        "client_ip": "181.221.64.40",
        "products": [
            {
                "price": 12.5,
                "name": "Extrato De Propolis Marrom 35Ml",
                "model_title": "default",
                "model_id": "172b3e69d85c4906",
                "id": "5e13874f198868e13148ff9f",
                "qtd": 3.0,
                "image": "858c185360de492eaea216bec89f4906.jpeg",
                "subcategory": "5dfcd9adad5cd6c85f4ba5fd",
                "unit_type": "UNI",
                "bar_codes": [
                    "7896396002826",
                    "7896396030287"
                ],
                "model_internal_code": "744"
            },
            {
                "price": 29.9,
                "name": "Mel Laranjeira Minamel 500G",
                "model_title": "default",
                "model_id": "7c894b751cbd44b4",
                "id": "5e2adfd0cc97ec5dbd185582",
                "qtd": 1.0,
                "image": "add75fd80d124e99aa973211c92edf9d.jpeg",
                "subcategory": "5dfcd9adad5cd6c85f4ba5fd",
                "unit_type": "UNI",
                "bar_codes": [
                    "7896396001034"
                ],
                "model_internal_code": "14"
            }
        ],
        "store_id": "5dfccf3c3006aa81b4f242e2",
        "status": "ib_closed",
        "delivery_tax": 10.0,
        "seen": true,
        "created_at": "2020-01-24T12:20:36.439000+00:00",
        "delivery_hour": {
            "id": "tv27e2aD",
            "end_time": "18:00",
            "start_time": "14:00",
            "delivery_date": "2020-01-28T14:00:00+00:00"
        },
        "should_replace_missing_products": false,
        "code": "VXG9-ZGB7",
        "comment": "Casa dos fundos",
        "schedule": true,
        "platform": "ib_web",
        "delivery_info": {
            "city": "Campos dos Goytacazes",
            "country": "Brasil",
            "street_number": "117",
            "complement": "Casa - Rua do Arantes",
            "neighborhood": "Parque Bandeirantes",
            "street": "Rua Atanagildo de Freitas",
            "state": "RJ",
            "zipcode": "28085-210"
        },
        "last_modified": "2020-01-24T18:45:35.329000+00:00",
        "kits": [],
        "device": "Unknown;Windows;Chrome",
        "subtotal": 67.4,
        "discount": 0.0,
        "total": 77.4
    },
    "status": "success",
    "count": 1,
    "http_status": 200
}
```

### HTTP Request
`PUT /order/cnpj/<store-cnpj>/order_id/<order-id>`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`status` | string | required | See [Buy Status](#buy-status-properties).


## Register invoice
This API allows you to register invoice to buy.

```shell
curl -X PUT \
  http://localhost:8000/api_tetra/payment/cnpj/23406149000170/5dbc94a66beb9440d5acd000 \
  -H 'api-token: 18aaab24-581b-4e1d-9a44-e876cb4cea22' \
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
`PUT /payment/cnpj/<store-cnpj>/<buy-id>`
