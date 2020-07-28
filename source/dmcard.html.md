---
title: Instabuy DMCard API Doc

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

Welcome to Instabuy's **REST** Raffle API. This API allows you to provide functions and data to your raffle.

To check other docs, click above:

- [Client API Doc](/).

## URLs
For production purpose you should use [https://api.instabuy.com.br/dmcard](https://api.instabuy.com.br/dmcard).

## Postman
If you want you can download our [Postman Collection](https://www.getpostman.com/collections/62569c93f4212557e5b8) to test your requests. 

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

# Authentication

The Authentication in Instabuy's DMCard API is made using **API-KEY**. Therefore, to access all endpoints you must pass the API_KEY in the request header as a `api-token` field. Please contact Instabuy's team to get your API-KEY.



# User
This API allows you to create and get users.


## Retrieve User
This API allows you to get user ID.

```shell
curl -X GET \
http://api.instabuy.com.br/dmcard/user \
-H 'api-token: SEU_API_TOKEN' \
-F email=cayke10@gmail.com
```

> JSON response example:

```json
{  
    "data": {
        "created_at": "2020-07-26T21:15:59.727000+00:00",
        "user_type": "PF",
        "id": "56d1d826072d4127fb6fb9f9",
    },
    "status": "success",
    "count": 1,
    "http_status": 200
}
```

### HTTP Request
`GET /user`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`email` | string | optional | User email.
`cpf` | string | optional | User cpf.

You must pass `email` or `cpf`.


## Create User
This API allows you to create new User.

```shell
curl -X POST \
  http://api.instabuy.com.br/dmcard/user \
  -H 'api-token: SEU_API_TOKEN' \
  -F email=teste@dmcard.com \
  -F cpf=822.487.800-79 \
  -F gender=M \
  -F 'phone=(61)91214-4567' \
  -F first_name=Teste \
  -F last_name=DMCard \
  -F birthday=22/01/1990
```

> JSON response example:

```json
{
    "data": {
        "gender": "M",
        "last_name": "DMCard",
        "addresses": [],
        "user_type": "PF",
        "cpf": "822.487.800-79",
        "cards": [],
        "id": "5d2dfa112e577465141804ed",
        "birthday": "1990-01-22T12:00:00+00:00",
        "phone": "(61)91214-4567",
        "created_at": "2019-07-16T16:23:45.393000+00:00",
        "email": "teste@dmcard.com",
        "first_name": "Teste"
    },
    "status": "success",
    "count": 0,
    "http_status": 200
}
```

### HTTP Request
`POST /user`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`email` | string | required | User email.
`password` | string | required | User password.
`phone` | string | required | User phone. `(XX)XXXXX-XXXX` format.
`first_name` | string | required for PF | User first name.
`last_name` | string | required for PF | User last name.
`gender` | string | required for PF | User gender. `F` or `M`.
`birthday` | string | required for PF | User birthday. `DD/MM/YYYY` format.
`cpf` | string | required for PF | User CPF.
`company_name` | string | required for PJ | User company name.
`fantasy_name` | string | required for PJ | User fantasy name.
`cnpj` | string | required for PJ | User CNPJ.

## User properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`email` | string | User email.
`phone` | string | User phone.
`user_type` | string | User type. If `PF` see [UserPF](#userpf-properties), if `PJ` see [UserPJ](#userpj-properties).

## UserPF properties
All UserPF inherit from User.

Attribute | Type | Description
-------------- | -------------- | -------------- 
`gender` | string | User gender. Either `F` or `M`.
`first_name` | string | User first name.
`last_name` | string | User last name.
`birthday` | datetime | User birthday.
`cpf` | string | User CPF.

## UserPJ properties
All UserPJ inherit from User.

Attribute | Type | Description
-------------- | -------------- | -------------- 
`company_name` | string | User company name.
`fantasy_name` | string | User fantasy name.
`cnpj` | string | User CNPJ.


# Raffle Participation
This API allows you to list invoices, luck numbers and add invoice for processing.


## Retrieve Raffle Participation
This API allows you to invoices added and luck numbers generated.

```shell
curl -X GET \
http://api.instabuy.com.br/dmcard/participation \
  -H 'api-token: SEU_API_TOKEN' \
  -F user_id=56d1d826072d4127fb6fb9f9 \
  -F raffle_id=5d2cfae5584eb1bd02a38a7b
```

> JSON response example:

```json
{
    "data": {
        "id": "5f1dfc289f4dbaf96b59a73b",
        "invoices": {
            "waiting": [
                {
                    "status": "waiting",
                    "access_key": "53200703696869000100650220004184721255485631"
                }
            ],
            "error": [
                {
                    "error": "Não foi possível encontrar nota fiscal na base da receita após 5 tentativas.",
                    "status": "error",
                    "access_key": "53200703696869000100650220004184711729099711"
                }
            ],
            "success": [
                {
                    "data": {
                        "valid_buy_total": 290.15,
                        "buy_total_read": 290.15,
                        "user_document_read": "034.874.481-14",
                        "buy_date_read": "2019-07-26T10:12:00+00:00"
                    },
                    "status": "success",
                    "access_key": "53190303696869000100650180000041399200839898"
                }
            ]
        },
        "created_at": "2020-07-26T21:56:56.351000+00:00",
        "luck_numbers": [
            {
                "remaining_balance": 80.3,
                "store": {
                    "name": "BIG BOX 402/3 Norte",
                    "cnpj": "03.696.869/0001-00"
                },
                "numbers": [
                    {
                        "number": 314750
                    },
                    {
                        "number": 709909
                    },
                    {
                        "number": 712662
                    },
                    {
                        "number": 719228
                    },
                    {
                        "number": 701923
                    }
                ]
            }
        ]
    },
    "status": "success",
    "count": 1,
    "http_status": 200
}
```

### HTTP Request
`GET /participation`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`user_id` | string | required | User Id.
`raffle_id` | string | required | Raffle Id.


## Register invoice
This API allows you to register invoice to be processed. The invoice should be processed in 24 hours.

```shell
curl -X POST \
  http://api.instabuy.com.br/dmcard/participation \
  -H 'api-token: SEU_API_TOKEN' \
  -F user_id=56d1d826072d4127fb6fb9f9 \
  -F 'invoice_url=http://dec.fazenda.df.gov.br/ConsultarNFCe.aspx?p=53190303696869000100650180000041399200839898|2|1|29|62.80|5849452b57487a7134375552654f435345746c58642f642f4f554d3d|1|BEFB4DA9F122C65B4695BBA0F3C514D83425892F' \
  -F raffle_id=5d2cfae5584eb1bd02a38a7b
```

> JSON response example:

```json
{
    "data": {
        "luck_numbers": [],
        "invoices": {
            "error": [],
            "success": [],
            "waiting": [
                {
                    "access_key": "53190303696869000100650180000041399200839898",
                    "status": "waiting",
                }
            ]
        },
        "created_at": "2020-07-26T21:56:56.351000+00:00",
        "id": "5f1dfc289f4dbaf96b59a73b"
    },
    "status": "success",
    "count": 1,
    "http_status": 200
}
```

### HTTP Request
`POST /coupon`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`user_id` | string | required | User Id.
`raffle_id` | string | required | Raffle Id.
`qr_code_url` | string | optional | QR Cocde Invoice url. The link read on invoice QR Code.
`access_key` | string | optional | Invoice access key.

You must pass `qr_code_url` or `access_key`.

## Raffle Participation properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`user_id` | string | User Id.
`raffle_id` | string | Raffle Id.
`invoices` | array | List with Invoices Status. See [Invoice Status](#invoice-status-properties).
`luck_numbers` | array | List with Raffle Store Luck Numbers. See [Store Luck Numbers](#store-luck-numbers-properties).

## Invoice Status properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`waiting` | array |	List with Invoices. See [Invoice](#invoice-properties).
`success` | array |	List with Invoices. See [Invoice](#invoice-properties).
`error` | array |	List with Invoices. See [Invoice](#invoice-properties).

## Invoice properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`access_key` | string | Invoice access key.
`status` | string | One of `waiting`, `success`, `error`, `running`.
`error` | string | If status == error, this field shows the error message in PT-BR.
`data` | object | If status == success, this field shows the invoice data processed. See [Invoice Data](#invoice-data-properties).

## Invoice Data properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`buy_date_read` | datetime | Invoice buy date.
`buy_total_read` | float | Invoice buy total value.
`valid_buy_total` | float | Buy total value valid for generating luck numbers. This value must be equal or less `buy_total_read` because some items(internal_code) are not allowed on raffle.
`user_document_read` | string | User cpf read on invoice. Optional - Invoice may not have been registered.

## Store Luck Numbers properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`store` | object | See [Store](#store-properties).
`remaining_balance` | float | User remaining balance in this store. This balance will sum to next invoices registered to generate luck numbers.
`numbers` | array | List with Luck Numbers. See [Luck Number](#luck-number-properties).

## Store properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`name` | string | Store name.
`cnpj` | string | Store cnpj.

## Luck Number properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`number` | int | Unique Sortable Number.

## Pending Coupon properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`qr_code_url` | string | QR Code invoice url.
`access_key` | string | Invoice access key.


# Raffle
This API allows you to get raffle info.


## Retrieve Raffle Participation
This API allows you to invoices added and luck numbers generated.

```shell
curl -X GET \
http://api.instabuy.com.br/dmcard/raffle \
  -H 'api-token: SEU_API_TOKEN' \
  -F id=5d2cfae5584eb1bd02a38a7b
```

> JSON response example:

```json
{
    "data": {
        "end_date": "2020-10-19T02:59:59+00:00",
        "start_date": "2019-01-07T10:00:00+00:00",
        "stores": [
            {
                "name": "BIG BOX 402/3 Norte",
                "cnpj": "03.696.869/0001-00"
            }
        ],
        "regulation_url": "https://bigbox.com.br/regulamento-da-promocao/",
        "title": "Sorteio Teste API",
        "id": "5f1df3723b6c3a193fdf227f",
        "rule": {
            "coupons_won": 1,
            "buy_value": 100.0
        }
    },
    "status": "success",
    "count": 1,
    "http_status": 200
}
```

### HTTP Request
`GET /raffle`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`id` | string | required | Raffle Id.

## Raffle properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`title` | string | Raffle title.
`start_date` | datetime | Raffle start date.
`end_date` | datetime | Raffle end date.
`regulation_url` | string | Regulation url.
`faq_url` | string | FAQ url. (optional)
`winners_url` | string | Url with winners list. (optional)
`stores` | array | List with Stores. See [Store](#store-properties).
`rule` | object | See [Raffle Rule](#raffle-rule-properties).


## Raffle Rule properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`coupons_won` | int | How many luck numbers will be generated after each buy_value spend.
`buy_value` | float | Buy value to generate luck numbers.
