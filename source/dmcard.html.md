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

<!-- For development purpose you should use [http://dev.api.instabuy.com.br/api_raffle](http://dev.api.instabuy.com.br/api_raffle). -->

For production purpose you should use [https://api.instabuy.com.br/dmcard](https://api.instabuy.com.br/dmcard).

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

The Authentication in Instabuy's DMCard API is made using **API-KEY**. Therefore, to access all endpoints you must pass the API_KEY in the request header as a `api-token` field. Please contact Instabuy's team to get your API-KEY.



# User
This API allows you to create, edit and get users.

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

## Retrieve User
This API allows you to get user data.

```shell
curl -X GET \
http://localhost:8000/dmcard/user \
-H 'api-token: 77e3f90a-e649-4ea7-a55c-3e4e9a9ce05a' \
-F email=cayke10@gmail.com
```

> JSON response example:

```json
{  
   "data":{  
      "first_name":"Cayke",
      "id":"56d1d826072d4127fb6fb9f9",
      "addresses":[],
      "last_name":"Prudente",
      "cpf":"034.123.765-14",
      "birthday":"1990-04-21T12:00:00+00:00",
      "user_type":"PF",
      "phone":"(61)99999-3871",
      "email":"cayke@gmail.com",
      "gender":"M",
      "cards":[]
   },
   "status":"success",
   "count":0,
   "http_status":200
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
  http://localhost:8000/dmcard/user \
  -H 'api-token: 77e3f90a-e649-4ea7-a55c-3e4e9a9ce05a' \
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



# Coupons
This API allows you to list coupons and add invoice for processing.

## Raffle Participation properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`user` | object | If `PF` see [UserPF](#userpf-properties), if `PJ` see [UserPJ](#userpj-properties).
`raffle` | object | See [Raffle](#raffle-properties).
`coupons` | array | List with Coupons. See [Coupon](#coupon-properties).
`pending_coupons` | array | List with Pending Coupons. See [Pending Coupon](#pending-coupon-properties).

## Raffle properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`name` | string | Raffle name.

## Coupon properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`balance` | float |	User remaining balance after generating sortable numbers.
`store` | object | See [Store](#store-properties).
`sortable_numbers` | array | List with Sortables. See [Sortable](#sortable-properties).

## Store properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`name` | string | Store name.

## Sortable properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`number` | int | Unique Sortable Number.
`created_at` | date | Coupon creation date(processed date).
`buy_date` | date | Buy Invoice date.

## Pending Coupon properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`invoice_url` | string | Invoice url.
`access_key` | string | Invoice access key.


## Retrieve Coupons
This API allows you to get user data.

```shell
curl -X GET \
http://localhost:8000/dmcard/coupon \
  -H 'api-token: 77e3f90a-e649-4ea7-a55c-3e4e9a9ce05a' \
  -F user_id=56d1d826072d4127fb6fb9f9 \
  -F raffle_id=5d2cfae5584eb1bd02a38a7b
```

> JSON response example:

```json
{
    "data": {
        "raffle": {
            "created_at": "2019-07-15T22:15:01.960000+00:00",
            "stores": [
                {
                    "created_at": "2019-07-15T22:15:02.024000+00:00",
                    "id": "5d2cfae6584eb1bd02a38a7c",
                    "name": "BigBox 402 norte"
                }
            ],
            "start_date": "2019-01-15T00:00:00+00:00",
            "rule": {
                "coupons_won": 1,
                "buy_value": 20.0
            },
            "end_date": "2019-10-15T23:59:59+00:00",
            "id": "5d2cfae5584eb1bd02a38a7b",
            "name": "Sorteio teste aniversário UltraBox\/BigBox"
        },
        "created_at": "2019-07-22T20:20:41.492000+00:00",
        "id": "5d361a995ce78324a6e53a6b",
        "pending_coupons": [],
        "coupons": [
            {
                "sortable_numbers": [
                    {
                        "created_at": "2019-07-22T22:17:47.779000+00:00",
                        "buy_date": "2019-03-29T17:58:00+00:00",
                        "number": 584900
                    },
                    {
                        "created_at": "2019-07-22T22:17:47.781000+00:00",
                        "buy_date": "2019-03-29T17:58:00+00:00",
                        "number": 728469
                    },
                    {
                        "created_at": "2019-07-22T22:17:47.782000+00:00",
                        "buy_date": "2019-03-29T17:58:00+00:00",
                        "number": 906266
                    }
                ],
                "store": {
                    "created_at": "2019-07-15T22:15:02.024000+00:00",
                    "id": "5d2cfae6584eb1bd02a38a7c",
                    "name": "BigBox 402 norte"
                },
                "balance": 2.8
            }
        ]
    },
    "status": "success",
    "count": 0,
    "http_status": 200
}
```

### HTTP Request
`GET /coupon`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`user_id` | string | required | User Id.
`raffle_id` | string | required | Raffle Id.


## Register invoice
This API allows you to register invoice to be processed. The invoice should be processed in 24 hours.

```shell
curl -X POST \
  http://localhost:8000/dmcard/coupon \
  -H 'api-token: 77e3f90a-e649-4ea7-a55c-3e4e9a9ce05a' \
  -F user_id=56d1d826072d4127fb6fb9f9 \
  -F 'invoice_url=http://dec.fazenda.df.gov.br/ConsultarNFCe.aspx?p=53190303696869000100650180000041399200839898|2|1|29|62.80|5849452b57487a7134375552654f435345746c58642f642f4f554d3d|1|BEFB4DA9F122C65B4695BBA0F3C514D83425892F' \
  -F raffle_id=5d2cfae5584eb1bd02a38a7b
```

> JSON response example:

```json
{
    "data": {
        "raffle": {
            "end_date": "2019-10-15T23:59:59+00:00",
            "start_date": "2019-07-15T00:00:00+00:00",
            "name": "Sorteio teste aniversário UltraBox\/BigBox",
            "rule": {
                "buy_value": 20.0,
                "coupons_won": 1
            },
            "id": "5d2cfae5584eb1bd02a38a7b",
            "created_at": "2019-07-15T22:15:01.960000+00:00",
            "stores": [
                {
                    "name": "BigBox 402 norte",
                    "id": "5d2cfae6584eb1bd02a38a7c",
                    "created_at": "2019-07-15T22:15:02.024000+00:00"
                }
            ]
        },
        "pending_coupons": [
            {
                "invoice_url": "http:\/\/dec.fazenda.df.gov.br\/consultarnfce.aspx?p=53190303696869000100650180000041399200839898|2|1|29|62.80|5849452b57487a7134375552654f435345746c58642f642f4f554d3d|1|befb4da9f122c65b4695bba0f3c514d83425892f"
            }
        ],
        "coupons": [],
        "id": "5d361a995ce78324a6e53a6b",
        "created_at": "2019-07-22T20:20:41.492000+00:00"
    },
    "status": "success",
    "count": 0,
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
`invoice_url` | string | optional | Invoice url. The link read on invoice QR Code.
`access_key` | string | optional | Invoice access key.

You must pass `invoice_url` or `access_key`.