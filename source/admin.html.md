---
title: Instabuy Admin API Doc

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

Welcome to Instabuy's **REST** Admin API. This API allows you to update products and get orders from your store.

To check other docs, click above:

- [Client API Doc](/).

## URLs

<!-- For development purpose you should use [http://dev.api.instabuy.com.br/api_raffle](http://dev.api.instabuy.com.br/api_raffle). -->

For production purpose you should use [https://api.instabuy.com.br/store](https://api.instabuy.com.br/store).

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

To download images, you must append the image key with Instabuy assets URL.

To download product images the base url is:

`https://assets.instabuy.com.br/ib.item.image.YYYY/X-{{product_image_key}}`.

Where YYYY and X are the pairs that indicates the image resolution.

Resolution (in pixels) | YYYY | X
-------------- | -------------- | --------------
150 x 150 | small | s
300 x 300 | medium | m
600 x 600 | big | b
1200 x 1200 | large | l


Exemple of product image with medium resolution and with image key == 20161023214840752541600349dcf4284c2592bd49355774b7b1.jpg: 

`https://assets.instabuy.com.br/ib.item.image.medium/m-20161023214840752541600349dcf4284c2592bd49355774b7b1.jpg`

# Authentication

The Authentication in Instabuy's API is made using **API-KEY**. Therefore, to access all endpoints you must pass the API_KEY in the request header as a `api-key` field. Please contact Instabuy's team to get your API-KEY.



# Products
This API allows you to update products info.

## Product properties
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`internal_code` | string | required | Unique identifier for the product.
`name` | string | required | Product name.
`price` | float | required | Product regular price.
`visible` | bool | optional | If product should be visible/active in e-commerce.
`stock` | float | optional | Product stock.
`barcodes` | array - [string] | optional | List with barcodes. These codes must be EAN8, EAN12 or EAN13.
`promo_price` | float | optional | 	Product promotional price.
`promo_start_at` | datetime | optional | Product promotional price start date. ISO format string.
`promo_end_at` | datetime | optional | Product promotional price end date. ISO format string.
`aux_codes` | array - [string] | optional | List with alphanumeric codes. These codes appear in collector application.
`auto_revoke_promo` | bool | optional | If this field is true, eventual active promo price will be removed from product when not passing valid promo fields.
`wholesale_price` | float | optional | Product wholesale price.
`wholesale_qtd` | float | optional | Product minimum quantity on cart that enables wholesale price.
`weight` | float | optional | Product weight in `kg`.
`length` | float | optional | Product length in `cm`.
`width` | float | optional | Product width in `cm`.
`height` | float | optional | Product height in `cm`.

<aside class="notice">
    For ERP integration you must pass: <b>internal_code, name, price, visible, stock, barcodes, promo_price, promo_start_at</b> and <b>promo_end_at</b>.
</aside>


## Update Products
This API allows you to update products.

```shell
curl --location --request PUT 'https://api.instabuy.com.br/store/products' \
--header 'api-key: uF9xALutdqfjPUnfbU1sKfYvITu-L5zgIQ5sTAoMRfw' \
--header 'Content-Type: application/json' \
--data-raw '{
	"products": [
			{
				"internal_code": "788924-5",
				"visible": true,
				"stock": 5,
				"name": "Vinho Taparaca 750ml",
				"barcodes": ["123483209485"],
				"price": 12.90,
				"promo_price": 9.90,
				"promo_end_at": "2020-03-31T23:59:59.672000-03:00",
				"weight": 1.5,
				"length": 10,
				"width": 10,
				"height": 10
			}
		]
}'
```

> JSON response example:

```json
{
    "data": {
        "status": "success",
        "count": 1,
        "updated": 1,
        "registered": 1
    },
    "status": "success",
    "count": 1,
    "http_status": 200
}
```

### HTTP Request
`PUT /products`

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
`client` | object | See [User](/index.html#user-properties).

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
`model_internal_code` | string | Product price internal code.

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
curl --location --request GET 'https://api.instabuy.com.br/store/buys?status=open' \
--header 'api-key: uF9xALutdqfjPUnfbU1sKfYvITu-L5zgIQ5sTAoMRfw' \
--header 'Content-Type: application/json'
```

> JSON response example:

```json
{
    "data": [
        {
            "created_at": "2020-01-20T19:14:07.036000+00:00",
            "last_modified": "2020-01-20T19:15:25.286000+00:00",
            "id": "5e25fbff07e6536be49f1eea",
            "online_payment_transaction_info": {},
            "code": "ZSQO-B71R",
            "seen": true,
            "status_history": [
                {
                    "message": "Alteração de status: Esperando Autorização -> Processando",
                    "created_at": "2020-01-20T19:15:14.465000+00:00",
                    "author": "ravierlopes2323@gmail.com",
                    "new_status": "ib_store_processing",
                    "old_status": "ib_wait_auth"
                }
            ],
            "device": "Unknown;Windows;Chrome",
            "client": {
                "addresses": [],
                "cpf": "705.882.561-00",
                "first_name": "Giovani",
                "last_name": "Rodrigues",
                "last_modified": "2021-01-15T19:08:16.545000+00:00",
                "created_at": "2019-05-21T17:15:41.032000+00:00",
                "gender": "M",
                "user_type": "PF",
                "phone": "(61) 99461-8398",
                "email": "giovani@gmail.com",
                "id": "5ce4323d6b8fbe43963e2427",
                "birthday": "1997-122-01T12:00:00+00:00"
            },
            "client_ip": "201.2.11.2",
            "kits": [],
            "status": "ib_store_processing",
            "billet_percent_discount": 0.0,
            "store_id": "55c17d73072d4126ea180fe5",
            "payment_info": {
                "method": "cash",
                "value": "250.0"
            },
            "products": [
                {
                    "name": "Blusa Lança Perfume Floral Multicolorida",
                    "model_title": "default",
                    "qtd_ordered": 1.0,
                    "image": "20151024032583937874d2b6235ecf64288b1d645b708003b36.jpg",
                    "bar_codes": [
                        "7896496917044"
                    ],
                    "unit_type": "UNI",
                    "qtd": 0.0,
                    "subcategory": "562ad0e4072d41701b289f8f",
                    "price": 129.9,
                    "model_internal_code": "1",
                    "id": "562ad1bc072d417034289f8e",
                    "model_id": "3fdef4d17a1d4122"
                },
                {
                    "name": "Bermuda Sarja Reserva Army Básica",
                    "model_title": "default",
                    "image": "2015102412525016200d8ac27ff0344a8db2fb3a59faa7d513.jpg",
                    "bar_codes": [
                        "7892840268046"
                    ],
                    "unit_type": "UNI",
                    "qtd": 1.0,
                    "subcategory": "562add93072d41709b289f8e",
                    "price": 90.15,
                    "model_internal_code": "RE499APM49PRQDB",
                    "id": "562addf0072d41709b289f8f",
                    "model_id": "200749d4cc814f12"
                }
            ],
            "schedule": false,
            "creator": "unknown",
            "comment": "",
            "platform": "ib_web",
            "should_replace_missing_products": false,
            "buy_type": "coll",
            "subtotal": 90.15,
            "discount": 0.0,
            "freight": 0.0,
            "total": 90.15
        },
        {
            "created_at": "2020-01-20T19:12:49.700000+00:00",
            "last_modified": "2020-03-02T17:32:14.080000+00:00",
            "id": "5e25fbb107e6536be49f1e17",
            "online_payment_transaction_info": {},
            "code": "GZ6G-PCUV",
            "seen": true,
            "status_history": [
                {
                    "message": "Alteração de status: Esperando Autorização -> Processando",
                    "created_at": "2020-03-02T17:32:14.067000+00:00",
                    "author": "separador@ib.com",
                    "new_status": "ib_store_processing",
                    "old_status": "ib_wait_auth"
                }
            ],
            "device": "Unknown;Windows;Chrome",
            "client": {
                "addresses": [],
                "cpf": "705.882.561-00",
                "first_name": "Giovani",
                "last_name": "Rodrigues",
                "last_modified": "2021-01-15T19:08:16.545000+00:00",
                "created_at": "2019-05-21T17:15:41.032000+00:00",
                "gender": "M",
                "user_type": "PF",
                "phone": "(61) 99461-8398",
                "email": "giovani@gmail.com",
                "id": "5ce4323d6b8fbe43963e2427",
                "birthday": "1997-122-01T12:00:00+00:00"
            },
            "client_ip": "201.2.11.2",
            "kits": [],
            "status": "ib_store_processing",
            "billet_percent_discount": 0.0,
            "store_id": "55c17d73072d4126ea180fe5",
            "payment_info": {
                "method": "cash",
                "value": "150.0"
            },
            "separator_email": "separador@ib.com",
            "products": [
                {
                    "name": "Blusa Lança Perfume Floral Multicolorida",
                    "model_title": "default",
                    "image": "20151024032583937874d2b6235ecf64288b1d645b708003b36.jpg",
                    "bar_codes": [
                        "7896496917044"
                    ],
                    "unit_type": "UNI",
                    "qtd": 1.0,
                    "subcategory": "562ad0e4072d41701b289f8f",
                    "price": 129.9,
                    "model_internal_code": "1",
                    "id": "562ad1bc072d417034289f8e",
                    "model_id": "3fdef4d17a1d4122"
                }
            ],
            "schedule": false,
            "creator": "unknown",
            "comment": "",
            "platform": "ib_web",
            "should_replace_missing_products": false,
            "buy_type": "coll",
            "subtotal": 129.9,
            "discount": 0.0,
            "freight": 0.0,
            "total": 129.9
        },
        {
            "created_at": "2019-12-03T15:52:50.290000+00:00",
            "last_modified": "2019-12-17T22:09:05.087000+00:00",
            "id": "5de684d2a94838107510b28b",
            "online_payment_transaction_info": {},
            "code": "TXAI-I85R",
            "seen": true,
            "status_history": [
                {
                    "message": "Alteração de status: Esperando Autorização -> Pedido a caminho",
                    "created_at": "2019-12-17T22:09:05.044000+00:00",
                    "author": "system",
                    "new_status": "ib_on_the_way",
                    "old_status": "ib_wait_auth"
                }
            ],
            "device": "Unknown;Mac;Chrome",
            "client": {
                "addresses": [],
                "cpf": "705.882.561-00",
                "first_name": "Giovani",
                "last_name": "Rodrigues",
                "last_modified": "2021-01-15T19:08:16.545000+00:00",
                "created_at": "2019-05-21T17:15:41.032000+00:00",
                "gender": "M",
                "user_type": "PF",
                "phone": "(61) 99461-8398",
                "email": "giovani@gmail.com",
                "id": "5ce4323d6b8fbe43963e2427",
                "birthday": "1997-122-01T12:00:00+00:00"
            },
            "installment": {
                "buy_min_value": 0.0,
                "interest": 0.0,
                "installments_number": 3
            },
            "client_ip": "189.75.101.248",
            "kits": [],
            "status": "ib_on_the_way",
            "billet_percent_discount": 0.0,
            "store_id": "55c17d73072d4126ea180fe5",
            "payment_info": {
                "method": "pagar_me_credit"
            },
            "products": [
                {
                    "name": "Açai ",
                    "model_title": "default",
                    "image": "1dacc25581a14997ae40a39645cfaaa0.jpeg",
                    "bar_codes": [],
                    "unit_type": "KG",
                    "qtd": 2.0,
                    "subcategory": "5cec1b66548656f0e85939ab",
                    "price": 12.0,
                    "model_internal_code": "fdd9f00a92",
                    "id": "5cec1b4678a584c4645934ee",
                    "model_id": "74e22366ec5f4b85"
                },
                {
                    "name": "Camiseta Colcci Clean Azul",
                    "model_title": "default",
                    "image": "201510240380720919bb50e3e0825b4fd7ba5dc1a05e1c43a1.jpg",
                    "bar_codes": [],
                    "unit_type": "UNI",
                    "qtd": 1.0,
                    "subcategory": "562ad0e4072d41701b289f8f",
                    "price": 65.0,
                    "model_internal_code": "4",
                    "id": "562ad2ea072d41703d289f8f",
                    "model_id": "e146b29f1a24429b"
                }
            ],
            "schedule": false,
            "creator": "unknown",
            "comment": "",
            "platform": "ib_web",
            "should_replace_missing_products": false,
            "buy_type": "coll",
            "subtotal": 89.0,
            "discount": 0.0,
            "freight": 0.0,
            "total": 89.0
        },
        {
            "created_at": "2019-12-03T15:45:22.190000+00:00",
            "last_modified": "2019-12-19T16:37:04.122000+00:00",
            "id": "5de68312f3112b453d10b1fa",
            "online_payment_transaction_info": {},
            "code": "7CM3-A241",
            "seen": true,
            "status_history": [
                {
                    "message": "Alteração de status: Esperando Autorização -> Processando",
                    "created_at": "2019-12-19T16:36:50.928000+00:00",
                    "author": "ravierlopes2323@gmail.com",
                    "new_status": "ib_store_processing",
                    "old_status": "ib_wait_auth"
                }
            ],
            "device": "Unknown;Mac;Chrome",
            "client": {
                "addresses": [],
                "cpf": "705.882.561-00",
                "first_name": "Giovani",
                "last_name": "Rodrigues",
                "last_modified": "2021-01-15T19:08:16.545000+00:00",
                "created_at": "2019-05-21T17:15:41.032000+00:00",
                "gender": "M",
                "user_type": "PF",
                "phone": "(61) 99461-8398",
                "email": "giovani@gmail.com",
                "id": "5ce4323d6b8fbe43963e2427",
                "birthday": "1997-122-01T12:00:00+00:00"
            },
            "client_ip": "189.75.101.248",
            "kits": [],
            "status": "ib_store_processing",
            "billet_percent_discount": 0.0,
            "store_id": "55c17d73072d4126ea180fe5",
            "payment_info": {
                "method": "check"
            },
            "products": [
                {
                    "name": "Açai ",
                    "model_title": "default",
                    "qtd_ordered": 2.0,
                    "image": "1dacc25581a14997ae40a39645cfaaa0.jpeg",
                    "bar_codes": [],
                    "unit_type": "KG",
                    "qtd": 1.0,
                    "subcategory": "5cec1b66548656f0e85939ab",
                    "price": 12.0,
                    "model_internal_code": "fdd9f00a92",
                    "id": "5cec1b4678a584c4645934ee",
                    "model_id": "74e22366ec5f4b85"
                },
                {
                    "name": "Camiseta Colcci Clean Azul",
                    "model_title": "default",
                    "image": "201510240380720919bb50e3e0825b4fd7ba5dc1a05e1c43a1.jpg",
                    "bar_codes": [],
                    "unit_type": "UNI",
                    "qtd": 1.0,
                    "subcategory": "562ad0e4072d41701b289f8f",
                    "price": 65.0,
                    "model_internal_code": "4",
                    "id": "562ad2ea072d41703d289f8f",
                    "model_id": "e146b29f1a24429b"
                }
            ],
            "schedule": false,
            "creator": "unknown",
            "comment": "",
            "platform": "ib_web",
            "should_replace_missing_products": false,
            "buy_type": "coll",
            "subtotal": 77.0,
            "discount": 0.0,
            "freight": 0.0,
            "total": 77.0
        },
        {
            "created_at": "2019-11-06T19:05:12.988000+00:00",
            "delivery_tax": 105.61,
            "last_modified": "2019-11-06T19:07:00.344000+00:00",
            "id": "5dc3196dc4f4a207bc891d4f",
            "online_payment_transaction_info": {},
            "code": "O4FA-SS10",
            "seen": true,
            "correios_tracking_code": "asdsadasdasdas123124s",
            "status_history": [
                {
                    "message": "Alteração de status: Esperando Autorização -> Pedido a caminho",
                    "created_at": "2019-11-06T19:06:33.432000+00:00",
                    "author": "cayke10@gmail.com",
                    "new_status": "ib_on_the_way",
                    "old_status": "ib_wait_auth"
                }
            ],
            "device": "Unknown;Mac;Chrome",
            "client": {
                "addresses": [],
                "cpf": "705.882.561-00",
                "first_name": "Giovani",
                "last_name": "Rodrigues",
                "last_modified": "2021-01-15T19:08:16.545000+00:00",
                "created_at": "2019-05-21T17:15:41.032000+00:00",
                "gender": "M",
                "user_type": "PF",
                "phone": "(61) 99461-8398",
                "email": "giovani@gmail.com",
                "id": "5ce4323d6b8fbe43963e2427",
                "birthday": "1997-122-01T12:00:00+00:00"
            },
            "client_ip": "189.75.101.248",
            "kits": [],
            "status": "ib_on_the_way",
            "billet_percent_discount": 0.0,
            "store_id": "55c17d73072d4126ea180fe5",
            "payment_info": {
                "method": "deposit"
            },
            "products": [
                {
                    "name": "Bermuda Sarja Reserva Army Básica",
                    "model_title": "default",
                    "image": "2015102412525016200d8ac27ff0344a8db2fb3a59faa7d513.jpg",
                    "bar_codes": [
                        "7892840268046"
                    ],
                    "unit_type": "UNI",
                    "qtd": 1.0,
                    "subcategory": "562add93072d41709b289f8e",
                    "price": 90.15,
                    "model_internal_code": "RE499APM49PRQDB",
                    "id": "562addf0072d41709b289f8f",
                    "model_id": "200749d4cc814f12"
                }
            ],
            "schedule": false,
            "delivery_info": {
                "country": "Brasil",
                "street_number": "213",
                "neighborhood": "Nossa Senhora de Lourdes",
                "zipcode": "95010-000",
                "complement": "",
                "street": "Avenida Júlio de Castilhos",
                "state": "RS",
                "city": "Caxias do Sul"
            },
            "creator": "unknown",
            "comment": "",
            "platform": "ib_web",
            "should_replace_missing_products": false,
            "buy_type": "sedex",
            "subtotal": 90.15,
            "discount": 0.0,
            "freight": 105.61,
            "total": 195.76
        },
        {
            "created_at": "2019-11-01T20:25:10.608000+00:00",
            "delivery_tax": 15.0,
            "last_modified": "2019-12-11T20:16:55.792000+00:00",
            "id": "5dbc94a66beb9440d5acd000",
            "online_payment_transaction_info": {},
            "code": "8WKC-30D0",
            "seen": true,
            "status_history": [
                {
                    "message": "Alteração de status: Esperando Autorização -> Processando",
                    "created_at": "2019-11-06T23:39:23.628000+00:00",
                    "author": "cayke@teste.com",
                    "new_status": "ib_store_processing",
                    "old_status": "ib_wait_auth"
                },
                {
                    "message": "Alteração de status: Processando -> Produtos separados",
                    "created_at": "2019-12-11T19:17:30.281000+00:00",
                    "author": "cayke10@gmail.com",
                    "new_status": "ib_ready",
                    "old_status": "ib_store_processing"
                },
                {
                    "message": "Alteração de status: Produtos separados -> Nota fiscal emitida",
                    "created_at": "2019-12-11T20:16:55.539000+00:00",
                    "author": "tetra",
                    "new_status": "ib_invoice_issued",
                    "old_status": "ib_ready"
                }
            ],
            "delivery_hour": {
                "start_time": "13:00",
                "delivery_date": "2019-11-05T13:00:00+00:00",
                "end_time": "17:30",
                "id": "c88ed"
            },
            "device": "Unknown;Mac;Chrome",
            "client": {
                "addresses": [],
                "cpf": "705.882.561-00",
                "first_name": "Giovani",
                "last_name": "Rodrigues",
                "last_modified": "2021-01-15T19:08:16.545000+00:00",
                "created_at": "2019-05-21T17:15:41.032000+00:00",
                "gender": "M",
                "user_type": "PF",
                "phone": "(61) 99461-8398",
                "email": "giovani@gmail.com",
                "id": "5ce4323d6b8fbe43963e2427",
                "birthday": "1997-122-01T12:00:00+00:00"
            },
            "client_ip": "164.41.42.18",
            "kits": [],
            "status": "ib_invoice_issued",
            "billet_percent_discount": 0.0,
            "store_id": "55c17d73072d4126ea180fe5",
            "payment_info": {
                "method": "cash",
                "value": "50.0"
            },
            "separator_email": "cayke@teste.com",
            "products": [
                {
                    "name": "Açai ",
                    "model_title": "default",
                    "image": "1dacc25581a14997ae40a39645cfaaa0.jpeg",
                    "bar_codes": [],
                    "unit_type": "UNI",
                    "qtd": 2.0,
                    "subcategory": "5cec1b66548656f0e85939ab",
                    "price": 12.0,
                    "model_internal_code": "fdd9f00a92",
                    "id": "5cec1b4678a584c4645934ee",
                    "model_id": "74e22366ec5f4b85"
                }
            ],
            "schedule": true,
            "delivery_info": {
                "country": "Brasil",
                "street_number": "02",
                "neighborhood": "Setor Noroeste",
                "zipcode": "70687-305",
                "complement": "",
                "street": "Quadra SQNW 311 Bloco A",
                "state": "DF",
                "city": "Brasília"
            },
            "creator": "unknown",
            "comment": "Compra Teste",
            "platform": "ib_web",
            "should_replace_missing_products": false,
            "buy_type": "deli",
            "subtotal": 24.0,
            "discount": 0.0,
            "freight": 15.0,
            "total": 39.0
        },
        {
            "created_at": "2019-11-01T20:20:03.806000+00:00",
            "delivery_tax": 50.0,
            "last_modified": "2020-02-03T18:50:32.455000+00:00",
            "id": "5dbc937362bae3b2a1acd230",
            "lumi_id": 745627,
            "online_payment_transaction_info": {},
            "code": "BRVW-IRZF",
            "seen": true,
            "status_history": [
                {
                    "message": "Alteração de status: Esperando Autorização -> Processando",
                    "created_at": "2019-11-06T23:38:55.410000+00:00",
                    "author": "cayke@teste.com",
                    "new_status": "ib_store_processing",
                    "old_status": "ib_wait_auth"
                },
                {
                    "message": "Alteração de status: Processando -> Produtos separados",
                    "created_at": "2020-01-23T18:53:34.648000+00:00",
                    "author": "silvamarcioms182@gmail.com",
                    "new_status": "ib_ready",
                    "old_status": "ib_store_processing"
                }
            ],
            "delivery_hour": {
                "start_time": "10:00",
                "delivery_date": "2019-11-02T10:00:00+00:00",
                "end_time": "13:30",
                "id": "771ee"
            },
            "device": "Unknown;Mac;Chrome",
            "client": {
                "addresses": [],
                "cpf": "705.882.561-00",
                "first_name": "Giovani",
                "last_name": "Rodrigues",
                "last_modified": "2021-01-15T19:08:16.545000+00:00",
                "created_at": "2019-05-21T17:15:41.032000+00:00",
                "gender": "M",
                "user_type": "PF",
                "phone": "(61) 99461-8398",
                "email": "giovani@gmail.com",
                "id": "5ce4323d6b8fbe43963e2427",
                "birthday": "1997-122-01T12:00:00+00:00"
            },
            "client_ip": "189.75.101.248",
            "kits": [],
            "status": "ib_ready",
            "billet_percent_discount": 0.0,
            "store_id": "55c17d73072d4126ea180fe5",
            "payment_info": {
                "method": "debit",
                "value": "Visa"
            },
            "separator_email": "cayke@teste.com",
            "products": [
                {
                    "name": "Camiseta Colcci Clean Azul",
                    "model_title": "default",
                    "qtd_ordered": 4.0,
                    "image": "201510240380720919bb50e3e0825b4fd7ba5dc1a05e1c43a1.jpg",
                    "bar_codes": [],
                    "unit_type": "UNI",
                    "qtd": 2.95,
                    "subcategory": "562ad0e4072d41701b289f8f",
                    "price": 65.0,
                    "model_internal_code": "4",
                    "id": "562ad2ea072d41703d289f8f",
                    "model_id": "e146b29f1a24429b"
                },
                {
                    "name": "Blusa Lança Perfume Floral Multicolorida",
                    "model_title": "default",
                    "qtd_ordered": 1.0,
                    "image": "20151024032583937874d2b6235ecf64288b1d645b708003b36.jpg",
                    "bar_codes": [
                        "7896496917044"
                    ],
                    "unit_type": "UNI",
                    "qtd": 0.0,
                    "subcategory": "562ad0e4072d41701b289f8f",
                    "price": 129.9,
                    "model_internal_code": "1",
                    "id": "562ad1bc072d417034289f8e",
                    "model_id": "3fdef4d17a1d4122"
                }
            ],
            "schedule": true,
            "delivery_info": {
                "country": "Brasil",
                "street_number": "36-A",
                "neighborhood": "Setor Habitacional Jardim Botânico (Lago Sul)",
                "zipcode": "71680-373",
                "complement": "Rua 12",
                "street": "Condomínio Residencial Mansões Itaipu",
                "state": "DF",
                "city": "Brasília"
            },
            "creator": "unknown",
            "comment": "",
            "platform": "ib_web",
            "should_replace_missing_products": false,
            "buy_type": "deli",
            "subtotal": 191.75,
            "discount": 0.0,
            "freight": 50.0,
            "total": 241.75
        },
        {
            "created_at": "2019-11-01T20:20:03.115000+00:00",
            "last_modified": "2019-11-03T23:25:14.167000+00:00",
            "id": "5dbc937362bae3b2a1acd22e",
            "online_payment_transaction_info": {},
            "code": "RN6S-K7L5",
            "seen": true,
            "status_history": [
                {
                    "message": "Alteração de status: Esperando Autorização -> Processando",
                    "created_at": "2019-11-03T23:25:10.954000+00:00",
                    "author": "ravierlopes2323@gmail.com",
                    "new_status": "ib_store_processing",
                    "old_status": "ib_wait_auth"
                },
                {
                    "message": "Alteração de status: Processando -> Confirmado",
                    "created_at": "2019-11-03T23:25:14.153000+00:00",
                    "author": "ravierlopes2323@gmail.com",
                    "new_status": "ib_confirmed",
                    "old_status": "ib_store_processing"
                }
            ],
            "delivery_hour": {
                "start_time": "13:00",
                "delivery_date": "2019-11-05T13:00:00+00:00",
                "end_time": "17:30",
                "id": "c88ed"
            },
            "device": "Unknown;Windows;Chrome",
            "client": {
                "addresses": [],
                "cpf": "705.882.561-00",
                "first_name": "Giovani",
                "last_name": "Rodrigues",
                "last_modified": "2021-01-15T19:08:16.545000+00:00",
                "created_at": "2019-05-21T17:15:41.032000+00:00",
                "gender": "M",
                "user_type": "PF",
                "phone": "(61) 99461-8398",
                "email": "giovani@gmail.com",
                "id": "5ce4323d6b8fbe43963e2427",
                "birthday": "1997-122-01T12:00:00+00:00"
            },
            "client_ip": "200.163.69.246",
            "kits": [],
            "status": "ib_confirmed",
            "billet_percent_discount": 0.0,
            "store_id": "55c17d73072d4126ea180fe5",
            "payment_info": {
                "method": "deposit"
            },
            "products": [
                {
                    "name": "Camiseta Colcci Clean Azul",
                    "model_title": "default",
                    "image": "201510240380720919bb50e3e0825b4fd7ba5dc1a05e1c43a1.jpg",
                    "bar_codes": [],
                    "unit_type": "UNI",
                    "qtd": 2.0,
                    "subcategory": "562ad0e4072d41701b289f8f",
                    "price": 65.0,
                    "model_internal_code": "4",
                    "id": "562ad2ea072d41703d289f8f",
                    "model_id": "e146b29f1a24429b"
                },
                {
                    "name": "Açai Plus",
                    "model_title": "default",
                    "image": "802ca81447e14a488dd6aedff3714762.jpeg",
                    "bar_codes": [],
                    "unit_type": "UNI",
                    "qtd": 2.0,
                    "subcategory": "5cec1b66548656f0e85939ab",
                    "price": 15.0,
                    "model_internal_code": "295c8d8711",
                    "id": "5cec1b9678a584c4645934f1",
                    "model_id": "9e2c2fe23d324b03"
                }
            ],
            "schedule": true,
            "creator": "unknown",
            "comment": "",
            "platform": "ib_web",
            "should_replace_missing_products": false,
            "buy_type": "coll",
            "subtotal": 160.0,
            "discount": 0.0,
            "freight": 0.0,
            "total": 160.0
        }
    ],
    "status": "success",
    "count": 8,
    "http_status": 200
}
```

### HTTP Request
`GET /buys`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`status` | string | required | One of: `open`, `erp_ready`, `canceled`, `finished`, `fraud_suspect`, `refunded`, `chargeback`.
`page` | int | optional | Page index.
`N` | int | optional | Number os max items to return per query.
`order_by` | string | optional | One of: `buy`, `delivery`, `last_buy`.

<aside class="notice">
    For ERP integration you must pass status : <b>erp_ready</b>. This status returns all buys that are ready for invoice issuing. After generating the invoice, you must edit buy status to <b>ib_invoice_issued</b>.
</aside>

## Retrieve especific buy
This API allows you to get a buy with Id.

```shell
curl --location --request GET 'https://api.instabuy.com.br/store/buys?id=5cec1b9678a584c4645934f1' \
--header 'api-key: uF9xALutdqfjPUnfbU1sKfYvITu-L5zgIQ5sTAoMRfw' \
--header 'Content-Type: application/json'
```

> JSON response example:

```json
{
    "data": {
        "created_at": "2019-11-01T20:20:03.115000+00:00",
        "last_modified": "2019-11-03T23:25:14.167000+00:00",
        "id": "5dbc937362bae3b2a1acd22e",
        "online_payment_transaction_info": {},
        "code": "RN6S-K7L5",
        "seen": true,
        "status_history": [
            {
                "message": "Alteração de status: Esperando Autorização -> Processando",
                "created_at": "2019-11-03T23:25:10.954000+00:00",
                "author": "ravierlopes2323@gmail.com",
                "new_status": "ib_store_processing",
                "old_status": "ib_wait_auth"
            },
            {
                "message": "Alteração de status: Processando -> Confirmado",
                "created_at": "2019-11-03T23:25:14.153000+00:00",
                "author": "ravierlopes2323@gmail.com",
                "new_status": "ib_confirmed",
                "old_status": "ib_store_processing"
            }
        ],
        "delivery_hour": {
            "start_time": "13:00",
            "delivery_date": "2019-11-05T13:00:00+00:00",
            "end_time": "17:30",
            "id": "c88ed"
        },
        "device": "Unknown;Windows;Chrome",
        "client": {
                "addresses": [],
                "cpf": "705.882.561-00",
                "first_name": "Giovani",
                "last_name": "Rodrigues",
                "last_modified": "2021-01-15T19:08:16.545000+00:00",
                "created_at": "2019-05-21T17:15:41.032000+00:00",
                "gender": "M",
                "user_type": "PF",
                "phone": "(61) 99461-8398",
                "email": "giovani@gmail.com",
                "id": "5ce4323d6b8fbe43963e2427",
                "birthday": "1997-122-01T12:00:00+00:00"
            },
        "client_ip": "200.163.69.246",
        "kits": [],
        "status": "ib_confirmed",
        "billet_percent_discount": 0.0,
        "store_id": "55c17d73072d4126ea180fe5",
        "payment_info": {
            "method": "deposit"
        },
        "products": [
            {
                "name": "Camiseta Colcci Clean Azul",
                "model_title": "default",
                "image": "201510240380720919bb50e3e0825b4fd7ba5dc1a05e1c43a1.jpg",
                "bar_codes": [],
                "unit_type": "UNI",
                "qtd": 2.0,
                "subcategory": "562ad0e4072d41701b289f8f",
                "price": 65.0,
                "model_internal_code": "4",
                "id": "562ad2ea072d41703d289f8f",
                "model_id": "e146b29f1a24429b"
            },
            {
                "name": "Açai Plus",
                "model_title": "default",
                "image": "802ca81447e14a488dd6aedff3714762.jpeg",
                "bar_codes": [],
                "unit_type": "UNI",
                "qtd": 2.0,
                "subcategory": "5cec1b66548656f0e85939ab",
                "price": 15.0,
                "model_internal_code": "295c8d8711",
                "id": "5cec1b9678a584c4645934f1",
                "model_id": "9e2c2fe23d324b03"
            }
        ],
        "schedule": true,
        "creator": "unknown",
        "comment": "",
        "platform": "ib_web",
        "should_replace_missing_products": false,
        "buy_type": "coll",
        "subtotal": 160.0,
        "discount": 0.0,
        "freight": 0.0,
        "total": 160.0
    },
    "status": "success",
    "count": 1,
    "http_status": 200
}
```

### HTTP Request
`GET /buys`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`id` | string | required | Buy id.


## Edit Buy Status
This API allows you to edit a buy status.

```shell
curl --location --request PUT 'https://api.instabuy.com.br/store/buys?id=5dbc937362bae3b2a1acd22e&status=ib_confirmed' \
--header 'api-key: uF9xALutdqfjPUnfbU1sKfYvITu-L5zgIQ5sTAoMRfw' \
--header 'Content-Type: application/json'
```

> JSON response example:

```json
{
    "data": {
        "created_at": "2019-11-01T20:20:03.115000+00:00",
        "last_modified": "2019-11-03T23:25:14.167000+00:00",
        "id": "5dbc937362bae3b2a1acd22e",
        "online_payment_transaction_info": {},
        "code": "RN6S-K7L5",
        "seen": true,
        "status_history": [
            {
                "message": "Alteração de status: Esperando Autorização -> Processando",
                "created_at": "2019-11-03T23:25:10.954000+00:00",
                "author": "ravierlopes2323@gmail.com",
                "new_status": "ib_store_processing",
                "old_status": "ib_wait_auth"
            },
            {
                "message": "Alteração de status: Processando -> Confirmado",
                "created_at": "2019-11-03T23:25:14.153000+00:00",
                "author": "ravierlopes2323@gmail.com",
                "new_status": "ib_confirmed",
                "old_status": "ib_store_processing"
            }
        ],
        "delivery_hour": {
            "start_time": "13:00",
            "delivery_date": "2019-11-05T13:00:00+00:00",
            "end_time": "17:30",
            "id": "c88ed"
        },
        "device": "Unknown;Windows;Chrome",
        "client": {
                "addresses": [],
                "cpf": "705.882.561-00",
                "first_name": "Giovani",
                "last_name": "Rodrigues",
                "last_modified": "2021-01-15T19:08:16.545000+00:00",
                "created_at": "2019-05-21T17:15:41.032000+00:00",
                "gender": "M",
                "user_type": "PF",
                "phone": "(61) 99461-8398",
                "email": "giovani@gmail.com",
                "id": "5ce4323d6b8fbe43963e2427",
                "birthday": "1997-122-01T12:00:00+00:00"
            },
        "client_ip": "200.163.69.246",
        "kits": [],
        "status": "ib_confirmed",
        "billet_percent_discount": 0.0,
        "store_id": "55c17d73072d4126ea180fe5",
        "payment_info": {
            "method": "deposit"
        },
        "products": [
            {
                "name": "Camiseta Colcci Clean Azul",
                "model_title": "default",
                "image": "201510240380720919bb50e3e0825b4fd7ba5dc1a05e1c43a1.jpg",
                "bar_codes": [],
                "unit_type": "UNI",
                "qtd": 2.0,
                "subcategory": "562ad0e4072d41701b289f8f",
                "price": 65.0,
                "model_internal_code": "4",
                "id": "562ad2ea072d41703d289f8f",
                "model_id": "e146b29f1a24429b"
            },
            {
                "name": "Açai Plus",
                "model_title": "default",
                "image": "802ca81447e14a488dd6aedff3714762.jpeg",
                "bar_codes": [],
                "unit_type": "UNI",
                "qtd": 2.0,
                "subcategory": "5cec1b66548656f0e85939ab",
                "price": 15.0,
                "model_internal_code": "295c8d8711",
                "id": "5cec1b9678a584c4645934f1",
                "model_id": "9e2c2fe23d324b03"
            }
        ],
        "schedule": true,
        "creator": "unknown",
        "comment": "",
        "platform": "ib_web",
        "should_replace_missing_products": false,
        "buy_type": "coll",
        "subtotal": 160.0,
        "discount": 0.0,
        "freight": 0.0,
        "total": 160.0
    },
    "status": "success",
    "count": 1,
    "http_status": 200
}
```

### HTTP Request
`PUT /buys`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`id` | string | required | Buy id.
`status` | string | required | See [Buy Status](#buy-status-properties).