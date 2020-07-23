---
title: Instabuy Client API Doc

language_tabs: # must be one of https://git.io/vQNgJ
  - json
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

code_clipboard: true
---

# Introduction

Welcome to **Instabuy's REST Client API**. This API allows you to provide functions and data to your e-commerce website/app, like products, categories, carts, buys, etc.

To check other docs, click above:

- [Admin Doc](/admin.html).
- [Linear Sistemas Doc](/linear.html).
- [DMCard Doc](/dmcard.html).
- [Tetra Soluções Doc](/tetra.html).

## URLs

For development purpose you should use [http://dev.api.instabuy.com.br/apiv3](http://dev.api.instabuy.com.br/apiv3).

For production purpose you should use [https://api.instabuy.com.br/apiv3](https://api.instabuy.com.br/apiv3).

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

## Store Identification
To identify your store and get your infos correctly you **must pass a store identifier on each request**. You must pass one of the following fields: `store_id`, `subdomain` or `custom_domain`. Theses values can be passed either via url argument or in request body.

E.g: To get the categories menu of a store you should implement one of the tree examples above:

`GET /menu?store_id=5a4d173b94e42937b3a6563a`

`GET /menu?subdomain=bigboxdelivery`

`GET /menu?custom_domain=bigboxdelivery.com.br`

## Images
All fields that represent images have only the image Identifier and not the image URL.
<!-- todo -->

# Authentication

The Authentication in Instabuy's API is made using **COOKIES**. Therefore, to log in and access protected endpoints you must have cookies enabled on your browser/app.

# Address
This API allow you to add, retrieve and delete addresses to the logged user.

## Address properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`zipcode` | string | Address zipcode.
`state` | string | Address state.
`city` | string | Address city.
`neighborhood` | string | Address neighborhood.
`street` | string | Adress Street name.
`street_number` | string | Address Street/House Number.
`complement` | string | Address complement.
`label` | string | Address descriptor.

## Retrieve an Address

> JSON response example:

```json
{
  "data": [
    {
      "zipcode": "70278-020",
      "id": "fbd26",
      "neighborhood": "Asa Sul",
      "street": "Quadra SQS 107 Bloco H",
      "street_number": "104",
      "country": "Brasil",
      "complement": "",
      "city": "Brasília",
      "label": "Casa",
      "state": "DF"
    },
    {
      "zipcode": "70910-900",
      "id": "c5571e",
      "neighborhood": "Asa Norte",
      "street": "Campus Universitário Darcy Ribeiro - Edificio CDT",
      "street_number": "AT 36/25",
      "country": "Brasil",
      "complement": "Sala Instabuy",
      "city": "Brasília",
      "label": "CDT",
      "state": "DF"
    }
  ],
  "status": "success",
  "count": 2,
  "http_status": 200
}
```

### HTTP Request
`GET /address`

## Add an Andress
This API adds an address to the user.

> JSON response example:

```json
{  
   "data":{  
      "zipcode":"70278-020",
      "id":"cac317",
      "neighborhood":"Asa Sul",
      "street":"Quadra SQS 412 Bloco D",
      "street_number":"123434",
      "country":"Brasil",
      "complement":"",
      "city":"Bras\u00edlia",
      "label":"teste",
      "state":"DF"
   },
   "status":"success",
   "count":1,
   "http_status":200
}
``` 

### HTTP Request
`POST /address`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`label` | string | required | Address descriptor.
`zipcode` | string | required | Address zipcode.
`state` | string | required | Address state.
`city` | string | required | Address city.
`neighborhood` | string | required | Address neighborhood.
`street` | string | required | Adress Street name.
`street_number` | string | required | Address Street/House Number.
`complement` | string | optional | Address complement.

## Delete an Address
This API deletes an address.

> JSON response example:

```json

{  
   "data":"ok",
   "status":"success",
   "count":0,
   "http_status":200
}
``` 

### HTTP Request
`DELETE /address`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`id` | string | required | Address Id.


# Buy
This API allows you to retrieve and get buys.

## Buy properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`created_at` | datetime | The date the resource was created.
`code` | string | Buy code.
`delivery_tax` | float | Buy delivery tax.
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

## Retrieve Buy
This API retrieves all buys made on store.

> JSON response example:

```json
{
  "data": [
    {
      "delivery_tax": 12.0,
      "created_at": "2019-04-04T21:00:21.275000+00:00",
      "code": "8YHL-UBF5",
      "id": "5ca670658050c003faefd46d",
      "status_history": [
        {
          "created_at": "2019-04-04T21:01:25.873000+00:00",
          "message": "Alteração de status: Esperando Autorização -> Cancelado. Motivo: teste",
          "old_status": "ib_wait_auth",
          "new_status": "ib_canceled"
        }
      ],
      "status": "ib_canceled",
      "delivery_hour": {
        "end_time": "12:00",
        "delivery_date": "2019-04-05T12:00:00+00:00",
        "start_time": "08:00"
      },
      "billet_percent_discount": 0.0,
      "store_id": "5a4d173b94e42937b3a6563a",
      "kits": [
        
      ],
      "payment_info": {
        "method": "credit",
        "value": "Visa"
      },
      "delivery_info": {
        "state": "DF",
        "street_number": "105",
        "city": "Brasília",
        "zipcode": "70278-020",
        "street": "Quadra SQS 412 Bloco B",
        "neighborhood": "Asa Sul",
        "complement": ""
      },
      "device": "web",
      "client": "56d1d826072d4127fb6fb9f9",
      "platform": "store_web",
      "buy_type": "deli",
      "schedule": true,
      "comment": "teste",
      "products": [
        {
          "bar_codes": [
            "7896445410510"
          ],
          "price": 16.99,
          "qtd": 2.0,
          "unit_type": "UNI",
          "model_internal_code": "055293-3",
          "model_id": "3859417c82f141d5",
          "image": "5485e5e388de44cc900bcb4588dab285.jpg",
          "model_title": "default",
          "name": "Água INDAIÁ sem Gás 10L ",
          "id": "5a73556994e4290629887f7b"
        },
        {
          "bar_codes": [
            "7891025106838"
          ],
          "price": 2.19,
          "qtd": 3.0,
          "unit_type": "UNI",
          "model_internal_code": "054330-6",
          "model_id": "6c686044363d49b6",
          "image": "b7f868aac2744225973ada262bebc866.jpg",
          "model_title": "default",
          "name": "Iogurte Grego DANONE Frutas Vermelhas 100g ",
          "id": "5a906f0b94e429040be13aa9"
        },
        {
          "bar_codes": [
            "7891025320623"
          ],
          "price": 6.99,
          "qtd": 1.0,
          "unit_type": "UNI",
          "model_internal_code": "049063-6",
          "model_id": "1c0b88ebf7554354",
          "image": "5f2fea6d81e9488c86d51eaa5f37ec72.jpg",
          "model_title": "default",
          "name": "Iogurte Grego DANONE Frutas Vermelhas 400g ",
          "id": "5a7b482b94e42929f89f3ee2"
        },
        {
          "bar_codes": [
            "7891000018750"
          ],
          "price": 1.99,
          "qtd": 1.0,
          "unit_type": "UNI",
          "model_internal_code": "017804-7",
          "model_id": "c5becf86cef641b3",
          "image": "c0681da21ed2406e885fc6d5f0af5102.jpg",
          "model_title": "default",
          "name": "Bono Recheado NESTLÉ Chocolate 140g",
          "id": "5a69eb9f94e4295629a6563b"
        },
        {
          "bar_codes": [
            "78910942"
          ],
          "price": 0.99,
          "qtd": 3.0,
          "unit_type": "UNI",
          "model_internal_code": "017433-5",
          "model_id": "1842f0498e6e451e",
          "image": "28d4ac6e04974a30881c9a017772b5ed.jpg",
          "model_title": "default",
          "name": "Refrigerante GUARANÁ ANTARCTICA Caçulinha 237ml",
          "id": "5a6b5ddf94e4291250a6563b"
        },
        {
          "bar_codes": [
            "7891962031170"
          ],
          "price": 1.19,
          "qtd": 4.0,
          "unit_type": "UNI",
          "model_internal_code": "014205-0",
          "model_id": "fb052197dc074053",
          "image": "4ba8532eac62494f97712b5234a2e1f3.jpg",
          "model_title": "default",
          "name": "Bolinho BAUDUCCO Duo Chocolate 40g",
          "id": "5a90455894e4296cdfe13aa9"
        },
        {
          "bar_codes": [
            "7892840226343",
            "7892840267841"
          ],
          "price": 2.59,
          "qtd": 4.0,
          "unit_type": "UNI",
          "model_internal_code": "015632-9",
          "model_id": "932d486d05884764",
          "image": "a5b899f0d907423388e54171ad51d0ae.jpeg",
          "model_title": "default",
          "name": "Biscoito EQLIBRI Panetini Presunto Parma 40g",
          "id": "5aa80ada94e4292dece7902f"
        },
        {
          "bar_codes": [
            "7892840236144",
            "7892840268046"
          ],
          "price": 2.59,
          "qtd": 1.0,
          "unit_type": "UNI",
          "model_internal_code": "051204-4",
          "model_id": "34ec7b3c4b9747e6",
          "image": "241fdd1ce7d7444db983fba7d4a4b88a.jpg",
          "model_title": "default",
          "name": "Biscoito EQLIBRI Panetini Tomate Temperado 40g",
          "id": "5a8c207d94e42970f4e13aa9"
        },
        {
          "bar_codes": [
            
          ],
          "price": 3.99,
          "qtd": 0.9,
          "unit_type": "UNI",
          "model_internal_code": "000050-7",
          "model_id": "f568769bab51472a",
          "image": "efe91da7cefa45829d8c5ba5557a3c2d.jpg",
          "model_title": "default",
          "name": "Banana Nanica Kg",
          "id": "5a55f4af94e429555aa6563a"
        },
        {
          "bar_codes": [
            "7893611120372"
          ],
          "price": 10.9,
          "qtd": 1.0,
          "unit_type": "UNI",
          "model_internal_code": "057555-0",
          "model_id": "ca81c4e069d64354",
          "image": "597c9b07ad40423f8f61b34ae179e306.jpeg",
          "model_title": "default",
          "name": "Castanha do Pará REI DAS CASTANHAS sem Casca 90g",
          "id": "5a561af794e4295e31a6563a"
        },
        {
          "bar_codes": [
            "7893611120334"
          ],
          "price": 11.9,
          "qtd": 1.0,
          "unit_type": "UNI",
          "model_internal_code": "057557-7",
          "model_id": "2142a16cdaae4e64",
          "image": "782ceba4648d46d6b62ba2f5022ad6fa.jpeg",
          "model_title": "default",
          "name": "Castanha de Caju REI DAS CASTANHAS Natural 90g",
          "id": "5a561c3694e4295e9fa6563a"
        }
      ],
      "store_dict": {
        "name": "BIG BOX Delivery",
        "address": {
          "state": "DF",
          "street_number": " Bloco \"A\"",
          "city": "Brasília",
          "zipcode": "77813-650",
          "street": "SHC/N EQ. 402/403",
          "neighborhood": "Asa Norte",
          "complement": ""
        }
      }
    }
  ],
  "status": "success",
  "count": 1,
  "http_status": 200
}
```

## Create Buy
This API allows you to create buy for user. The products are automatically retrieved from user cart.

> JSON response example:

```json
{
  "data": [
    {
      "delivery_tax": 12.0,
      "created_at": "2019-04-04T21:00:21.275000+00:00",
      "code": "8YHL-UBF5",
      "id": "5ca670658050c003faefd46d",
      "status_history": [
        {
          "created_at": "2019-04-04T21:01:25.873000+00:00",
          "message": "Alteração de status: Esperando Autorização -> Cancelado. Motivo: teste",
          "old_status": "ib_wait_auth",
          "new_status": "ib_canceled"
        }
      ],
      "status": "ib_canceled",
      "delivery_hour": {
        "end_time": "12:00",
        "delivery_date": "2019-04-05T12:00:00+00:00",
        "start_time": "08:00"
      },
      "billet_percent_discount": 0.0,
      "store_id": "5a4d173b94e42937b3a6563a",
      "kits": [
        
      ],
      "payment_info": {
        "method": "credit",
        "value": "Visa"
      },
      "delivery_info": {
        "state": "DF",
        "street_number": "105",
        "city": "Brasília",
        "zipcode": "70278-020",
        "street": "Quadra SQS 412 Bloco B",
        "neighborhood": "Asa Sul",
        "complement": ""
      },
      "device": "web",
      "client": "56d1d826072d4127fb6fb9f9",
      "platform": "store_web",
      "buy_type": "deli",
      "schedule": true,
      "comment": "teste",
      "products": [
        {
          "bar_codes": [
            "7896445410510"
          ],
          "price": 16.99,
          "qtd": 2.0,
          "unit_type": "UNI",
          "model_internal_code": "055293-3",
          "model_id": "3859417c82f141d5",
          "image": "5485e5e388de44cc900bcb4588dab285.jpg",
          "model_title": "default",
          "name": "Água INDAIÁ sem Gás 10L ",
          "id": "5a73556994e4290629887f7b"
        },
        {
          "bar_codes": [
            "7891025106838"
          ],
          "price": 2.19,
          "qtd": 3.0,
          "unit_type": "UNI",
          "model_internal_code": "054330-6",
          "model_id": "6c686044363d49b6",
          "image": "b7f868aac2744225973ada262bebc866.jpg",
          "model_title": "default",
          "name": "Iogurte Grego DANONE Frutas Vermelhas 100g ",
          "id": "5a906f0b94e429040be13aa9"
        },
        {
          "bar_codes": [
            "7891025320623"
          ],
          "price": 6.99,
          "qtd": 1.0,
          "unit_type": "UNI",
          "model_internal_code": "049063-6",
          "model_id": "1c0b88ebf7554354",
          "image": "5f2fea6d81e9488c86d51eaa5f37ec72.jpg",
          "model_title": "default",
          "name": "Iogurte Grego DANONE Frutas Vermelhas 400g ",
          "id": "5a7b482b94e42929f89f3ee2"
        },
        {
          "bar_codes": [
            "7891000018750"
          ],
          "price": 1.99,
          "qtd": 1.0,
          "unit_type": "UNI",
          "model_internal_code": "017804-7",
          "model_id": "c5becf86cef641b3",
          "image": "c0681da21ed2406e885fc6d5f0af5102.jpg",
          "model_title": "default",
          "name": "Bono Recheado NESTLÉ Chocolate 140g",
          "id": "5a69eb9f94e4295629a6563b"
        },
        {
          "bar_codes": [
            "78910942"
          ],
          "price": 0.99,
          "qtd": 3.0,
          "unit_type": "UNI",
          "model_internal_code": "017433-5",
          "model_id": "1842f0498e6e451e",
          "image": "28d4ac6e04974a30881c9a017772b5ed.jpg",
          "model_title": "default",
          "name": "Refrigerante GUARANÁ ANTARCTICA Caçulinha 237ml",
          "id": "5a6b5ddf94e4291250a6563b"
        },
        {
          "bar_codes": [
            "7891962031170"
          ],
          "price": 1.19,
          "qtd": 4.0,
          "unit_type": "UNI",
          "model_internal_code": "014205-0",
          "model_id": "fb052197dc074053",
          "image": "4ba8532eac62494f97712b5234a2e1f3.jpg",
          "model_title": "default",
          "name": "Bolinho BAUDUCCO Duo Chocolate 40g",
          "id": "5a90455894e4296cdfe13aa9"
        },
        {
          "bar_codes": [
            "7892840226343",
            "7892840267841"
          ],
          "price": 2.59,
          "qtd": 4.0,
          "unit_type": "UNI",
          "model_internal_code": "015632-9",
          "model_id": "932d486d05884764",
          "image": "a5b899f0d907423388e54171ad51d0ae.jpeg",
          "model_title": "default",
          "name": "Biscoito EQLIBRI Panetini Presunto Parma 40g",
          "id": "5aa80ada94e4292dece7902f"
        },
        {
          "bar_codes": [
            "7892840236144",
            "7892840268046"
          ],
          "price": 2.59,
          "qtd": 1.0,
          "unit_type": "UNI",
          "model_internal_code": "051204-4",
          "model_id": "34ec7b3c4b9747e6",
          "image": "241fdd1ce7d7444db983fba7d4a4b88a.jpg",
          "model_title": "default",
          "name": "Biscoito EQLIBRI Panetini Tomate Temperado 40g",
          "id": "5a8c207d94e42970f4e13aa9"
        },
        {
          "bar_codes": [
            
          ],
          "price": 3.99,
          "qtd": 0.9,
          "unit_type": "UNI",
          "model_internal_code": "000050-7",
          "model_id": "f568769bab51472a",
          "image": "efe91da7cefa45829d8c5ba5557a3c2d.jpg",
          "model_title": "default",
          "name": "Banana Nanica Kg",
          "id": "5a55f4af94e429555aa6563a"
        },
        {
          "bar_codes": [
            "7893611120372"
          ],
          "price": 10.9,
          "qtd": 1.0,
          "unit_type": "UNI",
          "model_internal_code": "057555-0",
          "model_id": "ca81c4e069d64354",
          "image": "597c9b07ad40423f8f61b34ae179e306.jpeg",
          "model_title": "default",
          "name": "Castanha do Pará REI DAS CASTANHAS sem Casca 90g",
          "id": "5a561af794e4295e31a6563a"
        },
        {
          "bar_codes": [
            "7893611120334"
          ],
          "price": 11.9,
          "qtd": 1.0,
          "unit_type": "UNI",
          "model_internal_code": "057557-7",
          "model_id": "2142a16cdaae4e64",
          "image": "782ceba4648d46d6b62ba2f5022ad6fa.jpeg",
          "model_title": "default",
          "name": "Castanha de Caju REI DAS CASTANHAS Natural 90g",
          "id": "5a561c3694e4295e9fa6563a"
        }
      ],
      "store_dict": {
        "name": "BIG BOX Delivery",
        "address": {
          "state": "DF",
          "street_number": " Bloco \"A\"",
          "city": "Brasília",
          "zipcode": "77813-650",
          "street": "SHC/N EQ. 402/403",
          "neighborhood": "Asa Norte",
          "complement": ""
        }
      }
    }
  ],
  "status": "success",
  "count": 1,
  "http_status": 200
}
```
### HTTP Request
`POST /buy`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`method_payment` | string | required | Buy method payment. Possible types: [`credit`, `check`, `debit`, `vale`, `cash`, `deposit`, `pagar_me_credit`, `pagar_me_billet`, `cielo_credit`, `cielo_debit`].
`value_payment` | string | required | Buy payment value. If method uses `card`, pass `card id` as `value_payment`. If method is `cash`, pass `exchange` value. Otherwise, dont send it.
`installments` | integer | required | Buy payment will be split in `installments` times.
`buy_type` | string | required | Buy recieptment type. Possible types: [`deli`, `coll`, `service`, `pac`, `sedex`].
`address_id` | string | required | If buy is `deli`, `pac` or `sedex`, you must pass delivery address Id.
`delivery_time_id` | string | required | If store schedules buys, send delivery hour Id.
`delivery_day` | string | required | If store schedules buys, send delivery day.
`shipping_tax` | string | required | Delivery/Shipping tax.
`items_total` | string | required | Buy subtotal(Items price).
`buy_total` | string | required | Buy total value. Subtotal + shipping - discounts.
`coupon_code` | string | optional | Coupon code.
`comment` | string | optional | Buy comment.
`device` | string | optional | Client Device Identifier.
`platform` | string | required | Client platform Identifier. Possible types: [`store_web`, `ib_web`, `store_android`, `store_ios`, `ib_android`, `ib_ios`, `unknown`].
`should_replace_missing_products` | string | optional | Client permission to store replacing missing products for equivalents.

# Card
This API allows you to retrive, add and delete user's credit card.

## Card properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`last_digits` | string | Card last four digits.
`first_digits` | string | Card first six digits.
`flag` | string | Card flag.
`holder_name` | string | Card holder name.
`expiration_date` | string | Card expiration date in `MMYY` format.
`billing_address` | object | Card billing address. See [Address](#address).

## Retrieve cards
This API allow you retrieve user credit cards.

> JSON response example:

```json
{
  "data": [
    {
      "last_digits": "8965",
      "holder_name": "Cayke Prudente",
      "id": "4ShW3eR0",
      "expiration_date": "0422",
      "billing_address": {
        "street": "Quadra SQS 412 Bloco D",
        "state": "DF",
        "city": "Brasília",
        "complement": "",
        "neighborhood": "Asa Sul",
        "zipcode": "70278-020",
        "country": "Brasil",
        "street_number": "204"
      },
      "flag": "mastercard",
      "first_digits": "516265"
    }
  ],
  "status": "success",
  "count": 1,
  "http_status": 200
}
``` 

## Add Card
This API adds a credit card to the logged user.

```json
{
  "data": {
    "last_digits": "8965",
    "holder_name": "Cayke Prudente",
    "id": "4ShW3eR0",
    "expiration_date": "0422",
    "billing_address": {
      "street": "Quadra SQS 412 Bloco D",
      "state": "DF",
      "city": "Brasília",
      "complement": "",
      "neighborhood": "Asa Sul",
      "zipcode": "70278-020",
      "country": "Brasil",
      "street_number": "204"
    },
    "flag": "mastercard",
    "first_digits": "516265"
  },
  "status": "success",
  "count": 1,
  "http_status": 200
}
``` 

### HTTP Request
`POST /card`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`card_number` | string | required | Card number.
`card_holder`| string | required | Card holder name.
`card_validate`| string | required | Card Expiration Date in format `MM/YYYY`.
`card_cvv`| string | required | Card Security Code (CVV).
`address_id`| string | required | Card billing address Id.

## Delete a Card
This API removes a card.

> JSON response example:

```json
{
  "data":"ok",
  "status":"success",
  "count":0,
  "http_status":200
}
``` 

### HTTP Request
`DELETE /card`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`card_id` | string | required | Card Id.

# Cart
The cart API allow you to add and retrieve products from the cart attached to the actual user identified by Cookies..

## Cart properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`products` | array |	Products data. See [Product properties](/#item-properties).
`kits` | array | Products Kit data. See [Products Kit properties](/#item-properties).

### Cart - ProductsKitBundle properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`bundle_id` | string |	ProductsKitBundle Id.
`products` | array | ProductsKitBundleProduct data. See [ProductsKitBundleProduct properties](/#cart-productskitbundleproduct-properties).

### Cart - ProductsKitBundleProduct properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`product_id` | string |	ProductsKitBundleProduct Id.
`qtd` | integer | Product quantity.

## Retrieve a cart

> JSON response example:

```json
{
  "data": {
    "products": [
      {
        "variation_items": [
          "563bd359072d41636efcdf30"
        ],
        "custom_infos": [
          
        ],
        "images": [
          "2015102413616602701d3812c6d09a54eae99801f107e109287.jpg",
          "20151024136179109673283e40ea200446e9e1adcaa2d5919c9.jpg"
        ],
        "store_id": "55c17d73072d4126ea180fe5",
        "subcategory_ids": [
          "562ae061072d4170a9289f8e"
        ],
        "increment_value": 1.0,
        "shipping": {
          "weight": 0.01,
          "processing_days": 0,
          "height": 1.0,
          "width": 1.0,
          "length": 1.0,
          "deliverable": true,
          "cls": "IBProductShipping"
        },
        "brand": "Polo HPC",
        "visible": true,
        "recurring_plan": {
          "is_billet": true,
          "trial_days": 0,
          "days": 30,
          "max_charges": 3,
          "is_credit": true,
          "cls": "IBItemPlan"
        },
        "description": "DETALHES DO PRODUTO\r\n\r\nO Sapatênis Polo HPC preto é confeccionado em lona com design iate. Apresenta bordado da marca e fecho em cadarço. Conta, ainda, com interior e palmilha macios, além de solado de borracha.\r\nINFORMAÇÕES\r\n\r\nSKU \tPO091SHM72FQH\r\nModelo\tPolo HPC RP-1602\r\nMaterial Externo\tTêxtil\r\nMaterial Interno\tTêxtil\r\nMaterial externo da sola\tBorracha\r\nCor\tPreto",
        "min_price_valid": 169.0,
        "qtd_sold": 66.0,
        "prices": [
          {
            "internal_code": "PO091SHM72FQH",
            "title": "default",
            "price": 169.0,
            "id": "1fb6c3f26b36428f",
            "qtd_stock": -1.0,
            "qtdOnCart": 2.0,
            "cls": "IBItemPrice",
            "bar_codes": [
              
            ]
          }
        ],
        "unit_type": "UNI",
        "slug": "Sapatenis-Polo-HPC-Preto",
        "name": "Sapatênis Polo HPC Preto",
        "available_stock": true,
        "id": "562ae092072d4170b4289f8e",
        "item_type": "product",
        "related_items": [
          
        ]
      },
      {
        "variation_items": [
          "562ad269072d41703d289f8e",
          "562ad1bc072d417034289f8e"
        ],
        "custom_infos": [
          {
            "field": "5b928eb4017ce27d51863aef",
            "cls": "IBItemCustomInfo",
            "value": "39cm"
          }
        ],
        "images": [
          "2015102412525016200d8ac27ff0344a8db2fb3a59faa7d513.jpg",
          "2015102412539650503f10e3528dbe46bb92826701b088e52d.jpg"
        ],
        "store_id": "55c17d73072d4126ea180fe5",
        "subcategory_ids": [
          "562add93072d41709b289f8e",
          "562ad0e4072d41701b289f8f",
          "562ad4f5072d417049289f8e"
        ],
        "increment_value": 1.0,
        "shipping": {
          "weight": 0.5,
          "processing_days": 0,
          "height": 1.0,
          "width": 1.0,
          "length": 1.0,
          "deliverable": true,
          "cls": "IBProductShipping"
        },
        "brand": "Reserva 2",
        "visible": true,
        "attachment": "https://s3-sa-east-1.amazonaws.com/ib.files.general/a809ad71339a4c808696243534350a09.jpg",
        "description": "DETALHES DO PRODUTO\r\n\r\nBermuda Sarja Reserva Army Básica Verona preta, com quatro bolsos e bordado da marca localizado. Tem modelagem reta, gancho médio e cinco passantes no cós. \r\n\r\nConfeccionada em sarja macia. Fechamento por zíper e botão. Acompanha cinto.\r\n\r\nCintura: 86cm/ Quadril: 104cm/ Gancho: 22cm/ Comprimento: 52cm/ Tamanho: 40. \r\n\r\nMedidas do Modelo: Altura 1,88m / Tórax 94cm / Manequim 40.\r\nINFORMAÇÕES\r\n\r\nSKU \tRE499APM49PRQ\r\nModelo\tReserva 1553\r\nMaterial\tAlgodão\r\nComposição\t100% Algodão\r\nCor\tPreto\r\nLavagem\tPode ser lavado na máquina",
        "min_price_valid": 90.15,
        "qtd_sold": 22.0,
        "prices": [
          {
            "internal_code": "RE499APM49PRQDB",
            "title": "default",
            "price": 90.15,
            "id": "200749d4cc814f12",
            "qtd_stock": -1.0,
            "qtdOnCart": 1.0,
            "cls": "IBItemPrice",
            "bar_codes": [
              "7892840268046"
            ]
          }
        ],
        "unit_type": "UNI",
        "slug": "Bermuda-Sarja-Reserva-Army-Basica",
        "name": "Bermuda Sarja Reserva Army Básica",
        "available_stock": true,
        "id": "562addf0072d41709b289f8f",
        "item_type": "product",
        "related_items": [
          
        ]
      }
    ],
    "kits": [
      {
        "variation_items": [
          
        ],
        "custom_infos": [
          
        ],
        "images": [
          "6e0bfe20046e4f558dd7e2fdf8721aee.jpeg"
        ],
        "store_id": "55c17d73072d4126ea180fe5",
        "subcategory_ids": [
          {
            "title": "camisola",
            "store_id": "55c17d73072d4126ea180fe5",
            "category_id": {
              "title": "Blusas legais",
              "show_order": 999,
              "store_id": "55c17d73072d4126ea180fe5",
              "visible": true,
              "slug": "Blusas-legais",
              "id": "5aeb277c94e4290b0178d67d"
            },
            "visible": true,
            "id": "5aeb27de94e4290b5378d67d"
          }
        ],
        "visible": true,
        "description": "",
        "min_price_valid": 1231.23,
        "qtd_sold": 1.0,
        "prices": [
          {
            "internal_code": "sedfsdf",
            "title": "default",
            "price": 1231.23,
            "id": "a81c1dcfb450456a",
            "qtd_stock": -1.0,
            "qtdOnCart": 1.0,
            "bar_codes": [
              
            ]
          }
        ],
        "slug": "afsg",
        "cart_id": "a5f11c92",
        "bundles": [
          {
            "name": "hueghf",
            "raise_products_price": false,
            "min_choice": 1,
            "id": "70c564f75f394363",
            "products": [
              {
                "additional_price": 0.0,
                "data": {
                  "variation_items": [
                    "562ad2b5072d417040289f8e",
                    "562ad269072d41703d289f8e",
                    "562ada29072d417077289f8e"
                  ],
                  "custom_infos": [
                    
                  ],
                  "images": [
                    "20151024032583937874d2b6235ecf64288b1d645b708003b36.jpg",
                    "20151024033022042628cfd7509aff418ab77257d2255cf326.jpg"
                  ],
                  "store_id": "55c17d73072d4126ea180fe5",
                  "subcategory_ids": [
                    "562ad0e4072d41701b289f8f"
                  ],
                  "increment_value": 1.0,
                  "shipping": {
                    "weight": 0.01,
                    "processing_days": 0,
                    "height": 1.0,
                    "width": 1.0,
                    "length": 1.0,
                    "deliverable": true,
                    "cls": "IBProductShipping"
                  },
                  "show_in_main_page": true,
                  "brand": "Lança Perfume",
                  "visible": true,
                  "description": "DETALHES DO PRODUTO\r\n\r\nA Blusa Lança Perfume Floral Multicolorida apresenta modelagem reta, estampa floral e mangas 3/4. Confeccionada em poliéster e elastano, oferece caimento leve e mobilidade. Medidas da Modelo: Altura: 1,79m / Busto: 87cm / Cintura: 62cm / Quadril: 90cm.\r\n\r\nOmbro: 12cm/ Manga: 31cm/ Busto: 84cm/ Comprimento: 53cm. Tamanho P.\r\nINFORMAÇÕES\r\n\r\nSKU \tLA906APF77OBE\r\nModelo\tLança Perfume 02BL240600\r\nComposição: 96% poliéster 4% elastano.\r\nCor\tMulticolorido",
                  "min_price_valid": 129.9,
                  "qtd_sold": 44.0,
                  "prices": [
                    {
                      "internal_code": "1",
                      "title": "default",
                      "price": 129.9,
                      "id": "3fdef4d17a1d4122",
                      "qtd_stock": -1.0,
                      "cls": "IBItemPrice",
                      "bar_codes": [
                        "7896496917044"
                      ]
                    }
                  ],
                  "unit_type": "UNI",
                  "slug": "Blusa-Lanca-Perfume-Floral-Multicolorida",
                  "name": "Blusa Lança Perfume Floral Multicolorida",
                  "available_stock": true,
                  "id": "562ad1bc072d417034289f8e",
                  "item_type": "product",
                  "related_items": [
                    "562ad269072d41703d289f8e",
                    "562ad2b5072d417040289f8e"
                  ]
                },
                "qtdOnCart": 1.0
              }
            ],
            "max_choice": 1
          },
          {
            "name": "teste",
            "raise_products_price": false,
            "min_choice": 1,
            "id": "fc19a8005f3a4b5d",
            "products": [
              {
                "additional_price": 0.0,
                "data": {
                  "variation_items": [
                    "562ad2b5072d417040289f8e",
                    "562ad269072d41703d289f8e",
                    "562ada29072d417077289f8e"
                  ],
                  "custom_infos": [
                    
                  ],
                  "images": [
                    "20151024032583937874d2b6235ecf64288b1d645b708003b36.jpg",
                    "20151024033022042628cfd7509aff418ab77257d2255cf326.jpg"
                  ],
                  "store_id": "55c17d73072d4126ea180fe5",
                  "subcategory_ids": [
                    "562ad0e4072d41701b289f8f"
                  ],
                  "increment_value": 1.0,
                  "shipping": {
                    "weight": 0.01,
                    "processing_days": 0,
                    "height": 1.0,
                    "width": 1.0,
                    "length": 1.0,
                    "deliverable": true,
                    "cls": "IBProductShipping"
                  },
                  "show_in_main_page": true,
                  "brand": "Lança Perfume",
                  "visible": true,
                  "description": "DETALHES DO PRODUTO\r\n\r\nA Blusa Lança Perfume Floral Multicolorida apresenta modelagem reta, estampa floral e mangas 3/4. Confeccionada em poliéster e elastano, oferece caimento leve e mobilidade. Medidas da Modelo: Altura: 1,79m / Busto: 87cm / Cintura: 62cm / Quadril: 90cm.\r\n\r\nOmbro: 12cm/ Manga: 31cm/ Busto: 84cm/ Comprimento: 53cm. Tamanho P.\r\nINFORMAÇÕES\r\n\r\nSKU \tLA906APF77OBE\r\nModelo\tLança Perfume 02BL240600\r\nComposição: 96% poliéster 4% elastano.\r\nCor\tMulticolorido",
                  "min_price_valid": 129.9,
                  "qtd_sold": 44.0,
                  "prices": [
                    {
                      "internal_code": "1",
                      "title": "default",
                      "price": 129.9,
                      "id": "3fdef4d17a1d4122",
                      "qtd_stock": -1.0,
                      "cls": "IBItemPrice",
                      "bar_codes": [
                        "7896496917044"
                      ]
                    }
                  ],
                  "unit_type": "UNI",
                  "slug": "Blusa-Lanca-Perfume-Floral-Multicolorida",
                  "name": "Blusa Lança Perfume Floral Multicolorida",
                  "available_stock": true,
                  "id": "562ad1bc072d417034289f8e",
                  "item_type": "product",
                  "related_items": [
                    "562ad269072d41703d289f8e",
                    "562ad2b5072d417040289f8e"
                  ]
                },
                "qtdOnCart": 1.0
              }
            ],
            "max_choice": 3
          }
        ],
        "name": "afsg",
        "available_stock": true,
        "id": "5c80125ccf2a20508f12dafc",
        "item_type": "products_kit",
        "related_items": [
          
        ]
      }
    ]
  },
  "status": "success",
  "count": 0,
  "http_status": 200
}
```

This API returns the cart.

### HTTP Request
`GET /cart`

## Add product to cart

> JSON response example:

```json
{
  "data":"ok",
  "status":"success",
  "count":0,
  "http_status":200
}
``` 

This API adds a product to cart and also changes product quantity.

### HTTP Request
`POST /cart`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`product_id` | string | required | Product Id.
`model_id` | string | required | Product's price Id.
`qtd` | float | required| Quantity to be added to cart.
`attachment` | string | optional | Attach a 'comment' to the product.

## Add products kit to cart

> JSON response example:

```json
The data field returns the kit_cart_id when a new kit is added to cart.
{
  "data":"a5f11c92",
  "status":"success",
  "count":0,
  "http_status":200
}
```

This API adds a products kit to cart. To change kit quantity on cart, pass `kit_cart_id` with `qtd`.

### HTTP Request
`POST /cart`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`kit_id` | string | required | Products Kit Id.
`kit_cart_id`| string | optional | Products Kit Cart Id.
`qtd` | float | required| Quantity to be added to cart.
`attachment` | string | optional | Attach a 'comment' to the product.
`bundles` | array | required | CartProductsKitBundle data. See [CartProductsKitBundle properties](/#cart-productskitbundle-properties).

## Add items from buy to cart
This API adds all items from a previously made buy to cart.

> JSON response example:

```json
{
  "data":"ok",
  "status":"success",
  "count":0,
  "http_status":200
}
``` 

### HTTP Request
`POST /cart`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`buy_id` | string | required | Buy Id.


## Clean a cart
This API removes all items from cart.

> JSON response example:

```json
{
  "data":[],
  "status":"success",
  "count":0,
  "http_status":200
}
``` 

### HTTP Request
`DELETE /cart`

# Contact Message
This API allows user to send a contact email to store.

> JSON response example:

```json
{  
   "data":"ok",
   "status":"success",
   "count":0,
   "http_status":200
}
```

### HTTP Request
`POST /message`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`email` | string | required | Client email.
`message` | string | required | Contact message.
`phone` | string | optional | Client phone.
`name` | string | optional | Cliente name.
`device` | string | optional | From what device the message were sent.
`file` | File | optional | An attachment File. Max 2mb size.


# Coupon
This API allows you to get coupons.

## Coupon properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`coupon_type` | string | Coupon discount type, can be: `buy_porc` - the discount is applied as a percentage of the buy subtotal; `buy_fixe` - the discount is applied as a fixed value; `deli_free` - the discount is equal the delivery freght value.
`code` | string | Coupon code.
`user` | string | Coupon Owner's email. If none, the coupon is public.
`discount_value` | number | The discount value. Can be applied as a % or plain value. Check `coupon_type`.
`uses_limit` | integer | How many times the coupon can be used.
`uses_count` | integer | How many times the coupon were used.

## Retrieve coupon
This API returns user coupons.

```json
{
  "data": [
    {
      "store_id": "5a4d173b94e42937b3a6563a",
      "expires_at": "2019-05-31T00:00:00+00:00",
      "user": "cayke10@gmail.com",
      "discount_value": 10.0,
      "id": "5cd0b374f305fe237219f332",
      "uses_limit": 10,
      "uses_count": 0,
      "code": "Y8EX-AQON",
      "coupon_type": "buy_porc"
    }
  ],
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
`code` | string | optional | Coupon code


# Delivery Schedule
This API allows you to get available delivery hours.

## Delivery Schedule properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`date` | string |	Delivery Day.
`weekday` | string | Delivery Day weekday.
`hours` | array | List of Delivery Hour. See [Hour properties](/#delivery-schedule-hour-properties).

## Delivery Schedule - Hour properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`start_time` | string | Begin of delivery hour.
`end_time` | string | End of delivery hour.
`setup_time` | string | Time to prepare buy.

## Retrieve delivery schedule
This API retrieves delivery schedule hours.

> JSON response example:

```json
{
  "data": [
    {
      "date": "09/05/2019",
      "weekday": "thursday",
      "hours": [
        {
          "end_time": "14:00",
          "setup_time": 2150,
          "start_time": "08:00",
          "id": "BWXdnS8N"
        }
      ]
    },
    {
      "date": "14/05/2019",
      "weekday": "tuesday",
      "hours": [
        {
          "end_time": "14:00",
          "setup_time": 2150,
          "start_time": "08:00",
          "id": "GbDmijHs"
        }
      ]
    },
    {
      "date": "16/05/2019",
      "weekday": "thursday",
      "hours": [
        {
          "end_time": "14:00",
          "setup_time": 2150,
          "start_time": "08:00",
          "id": "BWXdnS8N"
        }
      ]
    }
  ],
  "status": "success",
  "count": 0,
  "http_status": 200
}
``` 

### HTTP Request
`GET /available_schedules`


# Freight
The freight API allow you to get possible freight values for zipcode.

## Freight properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`delivery` | object |	Products data. See [Delivery properties](/#freight-delivery-properties).
`correios` | object | Products Kit data. See [Correios properties](/#freight-correios-properties).

### Freight - Delivery properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`freight` | float |	Freight value.
`free_above` | float | If buy value is higher than `free_above`, freight become free for the client.

### Freight - Correios properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`pac_price` | float |	Freight value using PAC.
`pac_max_deadline` | integer | PAC Delivery time (in days).
`sedex_price` | float |	Freight value using SEDEX.
`sedex_max_deadline` | integer | SEDEX Delivery time (in days).

<aside class="notice">
If the store doesn't delivers to the zipcode passed, the request field <code>data</code> will be equal <code>false</code>.
</aside>

## Retrieve freight
This API returns the freight value for zipcode.

> JSON response example for delivery:

```json
{  
   "data":{  
      "delivery":{  
         "free_above":100.0,
         "state":"DF",
         "city":"Bras\u00edlia",
         "store_id":"5a0056697058f5383127a0aa",
         "neighborhood":"Asa Sul",
         "id":"5b5e7384017ce2a4dff1b4a7",
         "freight":20.0,
         "creator":"unknown"
      }
   },
   "status":"success",
   "count":0,
   "http_status":200
}
``` 

> JSON response example for correios:

```json
{  
   "data":{  
      "correios":{  
         "pac_price":54.85,
         "pac_max_deadline":7,
         "sedex_price":99.45,
         "sedex_max_deadline":4
      }
   },
   "status":"success",
   "count":0,
   "http_status":200
}
``` 

### HTTP Request
`GET /hasdelivery`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`code` | string | required | Delivery address zipcode


# Item
The items API allows you to list items(products and products kits) from a store.

## Item properties

Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`item_type` | string | Item type. If equal `product` see [Product properties](#item-product-properties). If equal `products_kit` see [Products Kit properties](#item-products-kit-properties).
`custom_infos` | array | List of item infos. See [Custom Info properties](/#item-custom-info-properties).
`name` | string | Item name.
`subcategory_ids` | array | List of subcategories. See [Subcategory properties](#menu-subcategory-properties).
`prices` | array | List of prices. See [Price properties](#item-price-properties).
`description` | HTML | Item description in html format.
`min_price_valid` | number | The lowest value among all of its prices.
`available_stock` | boolean | If there is available sotck in at least one price.
`slug` | string | Category slug.
`meta_title` | string | Item's html meta title.
`meta_description` | string | Item's html meta description.
`images` | array | List of item images.
`variation_items` | array | List of variation items. See [Item properties](#item-properties).
`related_items` | array | List of related items. See [Item properties](#item-properties).

## Item - Custom Info properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`field` | object | Custom Info Field data. See [Custom Info Field properties](/#item-custom-info-field-properties).
`value` | string | The field's value.

## Item - Custom Info Field properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`title` | string | The field's title.

## Item - Price properties
An Item should have 1 or more prices. This attribute is used for creating variations/packing in the item.

Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`title` | string | The price's title.
`internal_code` | string | Price internal code - Used for matching with ERPs.
`qtd_stock`| float | Stock quantity. If -1 stock is not controled.
`bar_codes` | array | Item barcodes (strings).
`price` | float | Item regular price.
`promo_price` | float | Item promotional price.
`promo_end_at` | datettime | Item promotional price expiration date.

## Item - Product properties
All products inherit from Item. Below are the adittional attributes.

Attribute | Type | Description
-------------- | -------------- | -------------- 
`brand` | string | Item brand.
`increment_value` | number | Item minimum value to be added on cart. This is specially useful for weight items, where you should specify the 'unitary' weight for this item.
`unit_type` | string | Item unit type / measure system. Possible values: `UNI`, `KG`, `BOX`, `GR`, `M2`, `M`, `ML`, `L`.
`shipping` | object | Shipping data. See [Shipping properties](/#item-product-shipping-properties).

## Item - Product Shipping properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`length` | number |	Item packing length (in cm).
`height` | number | Item packing height (in cm).
`width` | number | Item packing width (in cm).
`weight`| number | Item packing weight (in kg).
`processing_days` | integer | Time to prepare product before sending it (in days).
`deliverable` | boolean | If item is deliverable.

## Item - Products Kit properties
All products kit inherit from Item. Below are the adittional attributes.

Attribute | Type | Description
-------------- | -------------- | -------------- 
`bundles` | array | List of Products Kit Bundle. See [Products Kit Bundle properties](/#item-products-kit-bundle-properties).

## Item - Products Kit Bundle properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`name` | string |	Bundle name.
`min_choice` | integer | Minimum products quantity that should be selected in this bundle. If equal `0` there is no minimum value.
`max_choice` | integer | Maximum products quantity that should be selected in this bundle. If equal `0` there is no maximum value.
`raise_products_value` | boolean | If `true`, this bundle price must be added to each product `additional_price` on the next bundle from array.
`products` | array | List of Products Kit Bundle Product. See [Products Kit Bundle Product properties](/#item-products-kit-bundle-product-properties).

## Item - Products Kit Bundle Product properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`data` | object |	Product data. See [Product properties](#item-product-properties).
`additional_price` | float | If this product should add additional price on kit price.

## List items
This API helps you to view all the items.

> JSON response example:

```json
{  
   "data":[  
      {  
         "custom_infos":[  
            {  
               "field":{  
                  "id":"5b92900a017ce27d51863b53",
                  "title":"Pa\u00eds"
               },
               "value":"Fran\u00e7a"
            },
            {  
               "field":{  
                  "id":"5b929008017ce27d51863b4f",
                  "title":"Produtor"
               },
               "value":"Louis Roederer"
            },
            {  
               "field":{  
                  "id":"5b929008017ce27d51863b50",
                  "title":"Uva"
               },
               "value":"Pinot Noir e Chardonnay"
            },
            {  
               "field":{  
                  "id":"5b929009017ce27d51863b51",
                  "title":"Teor Alco\u00f3lico"
               },
               "value":" 12%"
            },
            {  
               "field":{  
                  "id":"5b92a3a0017ce282c2845011",
                  "title":"Safra"
               },
               "value":"Dispon\u00edvel nas Safras 2006, 2007 e 2009."
            }
         ],
         "name":"Cristal Brut Louis Roederer 2007 e 2009  750ml",
         "increment_value":1.0,
         "subcategory_ids":[  
            {  
               "store_id":"5a0056697058f5383127a0aa",
               "id":"5bf4436f063e6409e4de43b9",
               "title":"Champagnes",
               "visible":true,
               "category_id":{  
                  "meta_description":"",
                  "store_id":"5a0056697058f5383127a0aa",
                  "id":"5bf4434a063e6409b3de43b9",
                  "title":"Champagnes",
                  "visible":true,
                  "slug":"Champagnes",
                  "show_order":7,
                  "meta_title":""
               }
            },
            {  
               "store_id":"5a0056697058f5383127a0aa",
               "id":"5ca4d2b48050c003fa37b891",
               "title":"Espumantes",
               "visible":true,
               "category_id":{  
                  "meta_description":"Sele\u00e7\u00e3o de vinhos e espumantes para o Dia das M\u00e3es",
                  "store_id":"5a0056697058f5383127a0aa",
                  "id":"5c3387bc063e64578c71623d",
                  "title":"Especial Dia das M\u00e3es ",
                  "visible":true,
                  "slug":"Dia-das-Maes",
                  "show_order":1,
                  "meta_title":"Especial Dia das M\u00e3es "
               }
            }
         ],
         "prices":[  
            {  
               "internal_code":"3461",
               "id":"52b6b538f69840a7",
               "promo_end_at":"2019-05-31T02:59:59+00:00",
               "bar_codes":[  
                  "3114080043059"
               ],
               "title":"default",
               "price":2004.47,
               "promo_price":1703.8,
               "qtd_stock":24.0
            }
         ],
         "unit_type":"UNI",
         "description":"Cobi\u00e7ado no mundo todo, o champagne Cristal foi criado em 1876 a pedido do czar Alexandre II, not\u00f3rio apaixonado pelos vinhos da maison Louis Roederer. \u00c9 um marco tamb\u00e9m por ter inaugurado uma nova categoria: a Cuv\u00e9e de Prestige, sendo elaborado apenas em anos excepcionais. Para criar um champagne ao gosto do exigente czar, Louis Roederer empreendeu uma sele\u00e7\u00e3o rigorosa das melhores uvas de seus Grands Crus. O Cristal 2007 \u00e9 um charmoso corte com 58% de Pinot Noir e 42% de Chardonnay, sendo 15% dos vinhos maturados em carvalho, com batonnage semanal. N\u00e3o h\u00e1 fermenta\u00e7\u00e3o malol\u00e1tica para preservar o \u00f3timo frescor. Este champagne maturou 5 anos nas caves, sendo 8 meses depois do disgorgement. O resultado \u00e9 um borbulhante que expressa a distin\u00e7\u00e3o de seu terroir.  Com bolhas impecavelmente finas, regulares e constantes. O ataque na boca remete a frutas brancas maduras, como pera, al\u00e9m frutas vermelhas \u00e1cidas e nuances de padaria, como de Tarte Tatin rec\u00e9m sa\u00edda do forno. Toques de mineralidade surgem na ponta da l\u00edngua. \u00c9 um champagne concentrado, com textura aveludada e grande profundidade. No nariz, s\u00e3o evidentes os aromas de chocolate e avel\u00e3, conferidos pela fermenta\u00e7\u00e3o em carvalho de parte dos vinhos dessa safra. Cristal 2007 \u00e9 um exemplo m\u00e1ximo de finesse.",
         "min_price_valid":1703.8,
         "available_stock":true,
         "shipping":{  
            "length":1.0,
            "height":1.0,
            "width":1.0,
            "weight":1.25,
            "processing_days":0,
            "deliverable":true
         },
         "id":"5b056b8f94e42951ad78d67e",
         "slug":"Cristal-Brut-Louis-Roederer-2007-750ml",
         "brand":"Louis Roederer",
         "images":[  
            "83cdb550dd564ec5bc7f79d2c43e8df7.jpg"
         ],
         "variation_items":[  

         ],
         "related_items":[  

         ],
         "item_type":"product"
      }
   ],
   "status":"success",
   "count":1,
   "http_status":200
}
``` 

### HTTP Request
`GET /item`

#### Available parameters
Parameter | Type | Description
-------------- | -------------- | -------------- 
`product_id` | string | Get Product with Id
`kit_id` | string | Get Products Kit with Id
`slug` | string | Get Item with slug
`subcategory_id` | string | Get Items from Subcategory
`category_id` | string | Get Items from Category
`category_slug` | string | Get Items from Category
`min_price` | float | Get Items with min price higher than `min_price`.
`max_price` | float | Get Items with min price lower than `max_price`.
`custom_info_{custom_info_id}` | string | The possible values for this should use `!$` separator. E.g.: `custom_info_5b929009017ce27d51863b52=1,5%20l!$750%20ml`
`sort` | string |	Sort collection by object attribute. Options: `nameaz`, `nameza`, `pricemin`, `pricemax`, `top_sellers` and `recents`. Default is `recents`.


# Item Filter
This API allows you to get possible Item filter based on category.

## Item Filter properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`title` | string | Filter title.
`values` | array |	List of strings.

## List Items Filters
This API helps you to view items filters from category.

> JSON response example:

```json
{
  "data": [
    {
      "id": "5b929009017ce27d51863b52",
      "title": "Volume",
      "values": [
        "1,5 l",
        "187 ml",
        "375 ml",
        "500 ml",
        "750 ml",
        "750ml"
      ]
    },
    {
      "id": "5b92900a017ce27d51863b53",
      "title": "País",
      "values": [
        "Alemanha",
        "Argentina",
        "Austrália",
        "Brasil",
        "Chile",
        "Espanha",
        "Estados Unidos",
        "FRANCES",
        "FRANÇA",
        "França",
        "ITALIA",
        "Itália",
        "Líbano",
        "PORTUGUES",
        "Portugal",
        "Uruguai",
        "África do Sul"
      ]
    },
    {
      "id": "5ca7b5118050c003f7e44c23",
      "title": "Região",
      "values": [
        "Saint-Julien"
      ]
    }
  ],
  "status": "success",
  "count": 0,
  "http_status": 200
}
``` 

### HTTP Request
`GET /custom_fields`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | -------------- | -------------- | -------------- 
`category_id` | string | required | Get Items Filters from Category.

# Layout 
This API allow you to get the home page items and banners.

## Layout properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`promo` | array |	List of Items in Promotion. See [Item properties](#item-properties).
`collection_items` | array | List of Categories. See [Collection properties](#layout-collection-properties).
`banners` | array | List of Banners. See [Banner properties](#layout-banner-properties).

## Layout - Collection properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`title` | string |	Category title.
`slug` | string | Category slug.
`items` | array |	List of Items in category. See [Item properties](#item-properties).

## Layout - Banner properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`show_order` | integer |	Banner show order position.
`href` | string | Banner redirect URL on click.
`image` | string | Banner image key.
`title` | string | Banner title.

## Retrieve Layout
This API helps you to view all the categories and subcategories.

> JSON response example:

```json
{
  "data": {
    "banners": [
      {
        "show_order": 1,
        "href": "p/562ae092072d4170b4289f8e/sapatenis-polo-hpc",
        "id": "5b5e737e017ce2a4dff1b1f7",
        "image": "2016041413500376793338371cac7b784f09be458dc25bf70697.jpg",
        "title": "oslosko"
      }
    ],
    "promo": [
      {
        "variation_items": [
          "562ada29072d417077289f8e"
        ],
        "id": "562ad9ff072d417074289f8e",
        "available_stock": true,
        "name": "Sutiã Calvin Klein unidadeerwear Push Up",
        "prices": [
          {
            "cls": "IBItemPrice",
            "promo_price": 90.0,
            "id": "487fad399b7546e2",
            "title": "default",
            "internal_code": "CA700APF82IZH",
            "bar_codes": [
              "7892840268046"
            ],
            "promo_end_at": "2019-05-31T15:22:59+00:00",
            "price": 119.0,
            "qtd_stock": -1.0
          }
        ],
        "slug": "Sutia-Calvin-Klein-Underwear-Push-Up",
        "custom_infos": [
          
        ],
        "min_price_valid": 90.0,
        "shipping": {
          "width": 1.0,
          "processing_days": 0,
          "height": 1.0,
          "length": 1.0,
          "cls": "IBProductShipping",
          "weight": 0.01,
          "deliverable": true
        },
        "description": "DETALHES DO PRODUTO\r\n\r\nSutiã Calvin Klein Underwear Push Up Nadador Renda Preto, com recorte nadador em renda, aro e bojo bolha. Tem modelagem push up, elástico inferior e alça finas reguláveis. Fechamento frontal por encaixe.\r\n\r\nConfeccionada em malha macia de toque suave.\r\n\r\nAltura da taça: 17cm/ Largura da taça: 18cm/ Tamanho: 36B.\r\nMedidas da Modelo: Altura: 1,71m / Busto: 86cm / Cintura: 59cm / Quadril: 89cm.\r\nINFORMAÇÕES\r\n\r\nSKU\t CA700APF82IZH\r\nMaterial\tPoliamida\r\nComposição\t90% Poliamida/ 10% Elastano\r\nCor\tPreto\r\nLavagem\tLavar a mão",
        "unit_type": "UNI",
        "increment_value": 1.0,
        "brand": "Calvin Klein Underwear",
        "related_items": [
          
        ],
        "images": [
          "2015102418121829759be270ce856340409718f0300c175244.jpg",
          "20151024181441855df61508ae8e8443f82e626e50ffd7ab4.jpg",
          "20151024181484131781f18d9c59914c83b34b1232128f260c.jpg",
          "20151024181545463914c54572d9b44d5c80fed56d1ed189fb.jpg"
        ],
        "item_type": "product",
        "subcategory_ids": [
          "562ad5e9072d41704f289f8e"
        ]
      }
    ],
    "collection_items": [
      {
        "id": "562acd4a072d417016289f8e",
        "title": "Calçados Masculinos",
        "slug": "Calcados-Masculinos",
        "items": [
          {
            "variation_items": [
              "563bd359072d41636efcdf30"
            ],
            "id": "562ae092072d4170b4289f8e",
            "available_stock": true,
            "name": "Sapatênis Polo HPC Preto",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "1fb6c3f26b36428f",
                "title": "default",
                "internal_code": "PO091SHM72FQH",
                "bar_codes": [
                  
                ],
                "price": 169.0,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Sapatenis-Polo-HPC-Preto",
            "custom_infos": [
              
            ],
            "min_price_valid": 169.0,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nO Sapatênis Polo HPC preto é confeccionado em lona com design iate. Apresenta bordado da marca e fecho em cadarço. Conta, ainda, com interior e palmilha macios, além de solado de borracha.\r\nINFORMAÇÕES\r\n\r\nSKU \tPO091SHM72FQH\r\nModelo\tPolo HPC RP-1602\r\nMaterial Externo\tTêxtil\r\nMaterial Interno\tTêxtil\r\nMaterial externo da sola\tBorracha\r\nCor\tPreto",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Polo HPC",
            "related_items": [
              
            ],
            "recurring_plan": {
              "trial_days": 0,
              "days": 30,
              "is_billet": true,
              "max_charges": 3,
              "is_credit": true,
              "cls": "IBItemPlan"
            },
            "images": [
              "2015102413616602701d3812c6d09a54eae99801f107e109287.jpg",
              "20151024136179109673283e40ea200446e9e1adcaa2d5919c9.jpg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "562ae061072d4170a9289f8e"
            ]
          }
        ]
      },
      {
        "id": "562acdf6072d41701b289f8e",
        "title": "Roupas Femininas",
        "slug": "Roupas-Femininas",
        "items": [
          {
            "variation_items": [
              "562ad2b5072d417040289f8e",
              "562ad269072d41703d289f8e",
              "562ada29072d417077289f8e"
            ],
            "id": "562ad1bc072d417034289f8e",
            "available_stock": true,
            "name": "Blusa Lança Perfume Floral Multicolorida",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "3fdef4d17a1d4122",
                "title": "default",
                "internal_code": "1",
                "bar_codes": [
                  "7896496917044"
                ],
                "price": 129.9,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Blusa-Lanca-Perfume-Floral-Multicolorida",
            "custom_infos": [
              
            ],
            "min_price_valid": 129.9,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nA Blusa Lança Perfume Floral Multicolorida apresenta modelagem reta, estampa floral e mangas 3/4. Confeccionada em poliéster e elastano, oferece caimento leve e mobilidade. Medidas da Modelo: Altura: 1,79m / Busto: 87cm / Cintura: 62cm / Quadril: 90cm.\r\n\r\nOmbro: 12cm/ Manga: 31cm/ Busto: 84cm/ Comprimento: 53cm. Tamanho P.\r\nINFORMAÇÕES\r\n\r\nSKU \tLA906APF77OBE\r\nModelo\tLança Perfume 02BL240600\r\nComposição: 96% poliéster 4% elastano.\r\nCor\tMulticolorido",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Lança Perfume",
            "show_in_main_page": true,
            "related_items": [
              "562ad269072d41703d289f8e",
              "562ad2b5072d417040289f8e"
            ],
            "images": [
              "20151024032583937874d2b6235ecf64288b1d645b708003b36.jpg",
              "20151024033022042628cfd7509aff418ab77257d2255cf326.jpg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "562ad0e4072d41701b289f8f"
            ]
          },
          {
            "variation_items": [
              "562ada29072d417077289f8e"
            ],
            "id": "562ad9ff072d417074289f8e",
            "available_stock": true,
            "name": "Sutiã Calvin Klein unidadeerwear Push Up",
            "prices": [
              {
                "cls": "IBItemPrice",
                "promo_price": 90.0,
                "id": "487fad399b7546e2",
                "title": "default",
                "internal_code": "CA700APF82IZH",
                "bar_codes": [
                  "7892840268046"
                ],
                "promo_end_at": "2019-05-31T15:22:59+00:00",
                "price": 119.0,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Sutia-Calvin-Klein-Underwear-Push-Up",
            "custom_infos": [
              
            ],
            "min_price_valid": 90.0,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nSutiã Calvin Klein Underwear Push Up Nadador Renda Preto, com recorte nadador em renda, aro e bojo bolha. Tem modelagem push up, elástico inferior e alça finas reguláveis. Fechamento frontal por encaixe.\r\n\r\nConfeccionada em malha macia de toque suave.\r\n\r\nAltura da taça: 17cm/ Largura da taça: 18cm/ Tamanho: 36B.\r\nMedidas da Modelo: Altura: 1,71m / Busto: 86cm / Cintura: 59cm / Quadril: 89cm.\r\nINFORMAÇÕES\r\n\r\nSKU\t CA700APF82IZH\r\nMaterial\tPoliamida\r\nComposição\t90% Poliamida/ 10% Elastano\r\nCor\tPreto\r\nLavagem\tLavar a mão",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Calvin Klein Underwear",
            "related_items": [
              
            ],
            "images": [
              "2015102418121829759be270ce856340409718f0300c175244.jpg",
              "20151024181441855df61508ae8e8443f82e626e50ffd7ab4.jpg",
              "20151024181484131781f18d9c59914c83b34b1232128f260c.jpg",
              "20151024181545463914c54572d9b44d5c80fed56d1ed189fb.jpg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "562ad5e9072d41704f289f8e"
            ]
          },
          {
            "variation_items": [
              "562ad269072d41703d289f8e",
              "562ad1bc072d417034289f8e"
            ],
            "id": "562addf0072d41709b289f8f",
            "available_stock": true,
            "name": "Bermuda Sarja Reserva Army Básica",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "200749d4cc814f12",
                "title": "default",
                "internal_code": "RE499APM49PRQDB",
                "bar_codes": [
                  "7892840268046"
                ],
                "price": 90.15,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Bermuda-Sarja-Reserva-Army-Basica",
            "custom_infos": [
              {
                "value": "39cm",
                "field": "5b928eb4017ce27d51863aef",
                "cls": "IBItemCustomInfo"
              }
            ],
            "min_price_valid": 90.15,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.5,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nBermuda Sarja Reserva Army Básica Verona preta, com quatro bolsos e bordado da marca localizado. Tem modelagem reta, gancho médio e cinco passantes no cós. \r\n\r\nConfeccionada em sarja macia. Fechamento por zíper e botão. Acompanha cinto.\r\n\r\nCintura: 86cm/ Quadril: 104cm/ Gancho: 22cm/ Comprimento: 52cm/ Tamanho: 40. \r\n\r\nMedidas do Modelo: Altura 1,88m / Tórax 94cm / Manequim 40.\r\nINFORMAÇÕES\r\n\r\nSKU \tRE499APM49PRQ\r\nModelo\tReserva 1553\r\nMaterial\tAlgodão\r\nComposição\t100% Algodão\r\nCor\tPreto\r\nLavagem\tPode ser lavado na máquina",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Reserva 2",
            "related_items": [
              
            ],
            "images": [
              "2015102412525016200d8ac27ff0344a8db2fb3a59faa7d513.jpg",
              "2015102412539650503f10e3528dbe46bb92826701b088e52d.jpg"
            ],
            "attachment": "https://s3-sa-east-1.amazonaws.com/ib.files.general/a809ad71339a4c808696243534350a09.jpg",
            "item_type": "product",
            "subcategory_ids": [
              "562add93072d41709b289f8e",
              "562ad0e4072d41701b289f8f",
              "562ad4f5072d417049289f8e"
            ]
          },
          {
            "variation_items": [
              "562ad9ff072d417074289f8e",
              "562ad2b5072d417040289f8e",
              "562ad1bc072d417034289f8e",
              "562ad269072d41703d289f8e"
            ],
            "id": "562ada29072d417077289f8e",
            "available_stock": true,
            "name": "Top Sofia By Vix Long Beach Multicolorido",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "56b5335383eb4d25",
                "title": "default",
                "internal_code": "SO327APF44SZN",
                "bar_codes": [
                  "7896058502107"
                ],
                "price": 239.0,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Top-Sofia-By-Vix-Long-Beach-Multicolorido",
            "custom_infos": [
              
            ],
            "min_price_valid": 239.0,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nTop Sofia By Vix Long Beach Multicolorido com estampa em tons contrastantes, bojo, modelagem cortininha, alça opcional, detalhes metalizados e fechamento por amarração. \r\n\r\nConfeccionada em tecido de poliamida com elastano. \r\n\r\nMedidas: Largura da taça: 16cm / Altura da taça: 12cm / Tamanho: P\r\n\r\nMedidas da Modelo: Altura 1,70m / Busto: 83cm / Cintura: 58cm / Quadril: 87cm.\r\nINFORMAÇÕES\r\n\r\nSKU \tSO327APF44SZN\r\nModelo\tSofia SC161106\r\nMaterial\tPoliamida\r\nComposição\t75% Poliamida/25% Elastano\r\nCor\tMulticolorido\r\nLavagem\tLavar a mão",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Sofia",
            "related_items": [
              "562ad9ff072d417074289f8e",
              "562ad2b5072d417040289f8e",
              "562ad1bc072d417034289f8e",
              "562ad269072d41703d289f8e"
            ],
            "images": [
              "2015102418555064573e653ad8bab643e5b93ea0ea31be938f.jpg",
              "201510241857440183f67ba4351d154f15927c0d9c018b45b4.jpg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "562ad631072d417052289f8f"
            ]
          },
          {
            "variation_items": [
              
            ],
            "id": "562ad946072d41706f289f8e",
            "available_stock": true,
            "name": "Casaco MNG Barcelona Lasu Off-white",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "2564ad2cd996471a",
                "title": "default",
                "internal_code": "MN408APF24HMD",
                "bar_codes": [
                  
                ],
                "price": 399.9,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Casaco-MNG-Barcelona-Lasu-Off-white",
            "custom_infos": [
              
            ],
            "min_price_valid": 399.9,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nO Casaco MNG Barcelona Lasu off-white apresenta recortes aparentes. Traz modelagem reta, mangas longas e abertura frontal.\r\n\r\nConfeccionado em tecido plano com toque macio. Acompanha forro. Medidas da Modelo: Altura 1,70m / Busto: 83cm / Cintura: 58cm / Quadril: 87cm.\r\n\r\nOmbro: 12cm/ Manga: 60cm/ Busto: 94cm/ Comprimento: 64cm/ Tamanho: P.\r\nINFORMAÇÕES\r\n\r\nSKU \tMN408APF24HMD\r\nModelo\tMNG Barcelona 44057600\r\nMaterial\tPoliéster\r\nComposição\tTecido Plano: 91%poliéster/ 9%elastano Forro: 100%poliéster\r\nCor\tBranco\r\nLavagem\tLavar a seco",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "MNG Barcelona",
            "related_items": [
              
            ],
            "images": [
              "20151024158833882fe614bfb2a9240b1b84e8cf0580f0862.jpg",
              "20151024151050984641d26f6236ee44e790d210fa2ce93b62.jpg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "562ad5aa072d417052289f8e"
            ]
          },
          {
            "variation_items": [
              
            ],
            "id": "562ad865072d417068289f8e",
            "available_stock": true,
            "name": "Vestido Mercatto Étnico Verde",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "89f2870c14264d13",
                "title": "default",
                "internal_code": "ME126APF14PCR",
                "bar_codes": [
                  
                ],
                "price": 119.9,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Vestido-Mercatto-Etnico-Verde",
            "custom_infos": [
              
            ],
            "min_price_valid": 119.9,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nVestido Mercatto Étnico verde, com estampa étnica ao longo da superfície, recorte em elástico, além de tiras cruzadas com ajuste frontal. Traz modelagem evasê, alças finas e decote arredondado.\r\n\r\nConfeccionado em tecido plano, que oferece toque macio.\r\n\r\nBusto: 94cm/ Comprimento: 96cm/ Tamanho: P. \r\n\r\nMedidas da modelo: Altura 1,79m / Busto 82cm / Cintura 63cm / Quadril 87cm.\r\nINFORMAÇÕES\r\n\r\nSKU \tME126APF14PCR\r\nModelo\tMercatto 2826526\r\nMaterial\tViscose\r\nComposição\tTecido Plano 100%viscose\r\nCor\tVerde\r\nLavagem\tLavar a mão",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Mercatto",
            "related_items": [
              
            ],
            "images": [
              "201510241122923368de8c4aa8d1384aebb6a0bba76bc6eb62.jpg",
              "201510241124805889af6a5ada65bd4d21b182ff345e1f9b76.jpg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "562ad6de072d417061289f8e"
            ]
          },
          {
            "variation_items": [
              
            ],
            "id": "562ad55e072d417049289f8f",
            "available_stock": true,
            "name": "Calça Jeans Levis Super Skinny Azul",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "86aa1149fbec4c99",
                "title": "default",
                "internal_code": "LE886APF42AVH",
                "bar_codes": [
                  
                ],
                "price": 219.0,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Calca-Jeans-Levis-Super-Skinny-Azul",
            "custom_infos": [
              
            ],
            "min_price_valid": 219.0,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nA Calça Jeans Levis Super Skinny azul possui lavagem estonada, pespontos contrastantes, detalhes de rebites, puídos propositais e cinco bolsos. Modelagem super skinny e fechamento por botão e zíper. \r\n\r\nConfeccionada em jeans maleável de caimento acentuado e toque confortável.\r\n\r\nCintura: 70cm / Quadril: 86cm / Gancho: 21cm / Comprimento: 100cm Tamanho: 28. \r\n\r\nMedidas da Modelo: Altura: 1,74m / Busto: 90cm / Cintura: 65cm / Quadril: 94cm.\r\nINFORMAÇÕES\r\n\r\nSKU \tLE886APF42AVH\r\nModelo\tLevis 177810001\r\nMaterial\tAlgodão\r\nComposição\tJeans: 68% Algodão / 23% Poliéster / 6% Viscose / 1% Elastano\r\nCor\tAzul\r\nLavagem\tPode ser lavado na máquina",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Levis",
            "related_items": [
              
            ],
            "images": [
              "20151024048286698998e226c4ef2a34be395e07abafe12e0fc.jpg",
              "20151024048303155116e573c0137084933ab82b4ab3e4f45e1.jpg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "562ad4f5072d417049289f8e"
            ]
          },
          {
            "variation_items": [
              
            ],
            "id": "562ad422072d417043289f8e",
            "available_stock": true,
            "name": "Regata Jeans Colcci Comfort Azul",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "76a0455a17fc4964",
                "title": "default",
                "internal_code": "CO515APF96APJ",
                "bar_codes": [
                  
                ],
                "price": 184.0,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Regata-Jeans-Colcci-Comfort-Azul",
            "custom_infos": [
              
            ],
            "min_price_valid": 184.0,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nRegata Jeans Colcci Comfort Azul, com lavagem delavê e bolso frontal. Tem modelagem mullet, cotas nadador e decote redondo.\r\n\r\nConfeccionada em jeans macio e maleável. \r\n\r\nBusto: 90cm/ Comprimento: 63cm/ Tamanho: P. \r\n\r\nMedidas da Modelo: Altura:1,71m / Busto: 82cm / Cintura: 60cm / Quadril: 90cm.\r\nINFORMAÇÕES\r\n\r\nSKU \tCO515APF96APJ\r\nModelo\tColcci 380102021\r\nMaterial\tAlgodão\r\nComposição\t100% Algodão\r\nCor\tAzul\r\nLavagem\tPode ser lavado na máquina",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Colcci ",
            "related_items": [
              
            ],
            "images": [
              "20151024043127923810d9446f18f994da890145190b9174212.jpg",
              "20151024043144736316ad55fc623ef42beb6cdc130665f6e00.jpg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "562ad0e4072d41701b289f8f"
            ]
          },
          {
            "variation_items": [
              
            ],
            "id": "562ad3dd072d417046289f8e",
            "available_stock": true,
            "name": "Regata Cantão Silk Azulejo Azul",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "196facf0ea9d4657",
                "title": "default",
                "internal_code": "CA558APF85IUG",
                "bar_codes": [
                  
                ],
                "price": 139.0,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Regata-Cantao-Silk-Azulejo-Azul",
            "custom_infos": [
              
            ],
            "min_price_valid": 139.0,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nRegata Cantão Silk Azulejo Azul, com estampa inspirada em azulejos, modelagem cropped e decote redondo.\r\n\r\nConfeccionada em malha grossa.\r\n\r\nBusto: 80cm/ Comprimento: 92cm/ Tamanho: P. \r\n\r\nComposição: 94% Poliéster/ 6% Elastano. \r\n\r\nMedidas da Modelo: Altura 1,77m / Busto: 81cm / Cintura: 59cm / Quadril: 89cm.\r\nINFORMAÇÕES\r\n\r\nSKU \tCA558APF85IUG\r\nModelo\tCantão 514051\r\nMaterial\tPoliéster\r\nComposição\t94% Poliéster/ 6% elastano\r\nCor\tAzul\r\nLavagem\tLavar a mão",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Cantão",
            "related_items": [
              
            ],
            "images": [
              "201510240422741115a8cd804ba9a848c8be69aab1e3e0b1e2.jpg",
              "201510240424246210320679804af747aea9c5c2d65064142c.jpg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "562ad0e4072d41701b289f8f"
            ]
          },
          {
            "variation_items": [
              
            ],
            "id": "562ad2ea072d41703d289f8f",
            "available_stock": true,
            "name": "Camiseta Colcci Clean Azul",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "e146b29f1a24429b",
                "title": "default",
                "internal_code": "4",
                "bar_codes": [
                  
                ],
                "price": 65.0,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Camiseta-Colcci-Clean-Azul",
            "custom_infos": [
              
            ],
            "min_price_valid": 65.0,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nCamiseta Colcci Clean azul com modelagem reta, decote arredondado e mangas curtas.\r\n\r\nConfeccionado em tecido macio e confortável.\r\n\r\nBusto: 108cm/ Comprimento: 70cm. Tamanho: P. \r\n\r\nMedidas da modelo: Altura 1,79m / Busto 82cm / Cintura 63cm / Quadril 87cm.\r\nINFORMAÇÕES\r\n\r\nSKU\tCO515APF10LAB\r\nModelo\tColcci 360111383\r\nMaterial\tViscose\r\nComposição\t100%viscose\r\nCor\tAzul\r\nLavagem\tLavar a mão",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Colcci",
            "related_items": [
              
            ],
            "images": [
              "201510240380720919bb50e3e0825b4fd7ba5dc1a05e1c43a1.jpg",
              "2015102403822347864d5aab1e61694468b1f4c3555edf49c8.jpg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "562ad0e4072d41701b289f8f"
            ]
          }
        ]
      },
      {
        "id": "563bcd55072d415f70fcdf30",
        "title": "Esporte Feminino",
        "slug": "Esporte-Feminino",
        "items": [
          
        ]
      },
      {
        "id": "5aeb277c94e4290b0178d67d",
        "title": "Blusas legais",
        "slug": "Blusas-legais",
        "items": [
          {
            "variation_items": [
              
            ],
            "id": "5c9914488050c003bc9c7e0d",
            "available_stock": true,
            "name": "Teste produto lumi",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "971ed4cad03748c7",
                "title": "default",
                "internal_code": "35",
                "bar_codes": [
                  
                ],
                "price": 2.0,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Teste-produto-lumi",
            "custom_infos": [
              
            ],
            "min_price_valid": 2.0,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "IB Lumi",
            "related_items": [
              
            ],
            "images": [
              "b2c4dd732a0145299fd35424d55431bd.jpeg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "5aeb27de94e4290b5378d67d"
            ],
            "main_subcategory": "5aeb27de94e4290b5378d67d"
          },
          {
            "variation_items": [
              
            ],
            "id": "5c80125ccf2a20508f12dafc",
            "available_stock": true,
            "name": "afsg",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "a81c1dcfb450456a",
                "title": "default",
                "internal_code": "sedfsdf",
                "bar_codes": [
                  
                ],
                "price": 1231.23,
                "qtd_stock": -1.0
              }
            ],
            "slug": "afsg",
            "custom_infos": [
              
            ],
            "min_price_valid": 1231.23,
            "description": "",
            "related_items": [
              
            ],
            "images": [
              "6e0bfe20046e4f558dd7e2fdf8721aee.jpeg"
            ],
            "item_type": "products_kit",
            "subcategory_ids": [
              "5aeb27de94e4290b5378d67d"
            ],
            "bundles": [
              {
                "max_choice": 1,
                "products": [
                  {
                    "data": "563bd359072d41636efcdf30",
                    "additional_price": 0.0,
                    "cls": "IBProductsKitBundleItem"
                  },
                  {
                    "data": "562ad1bc072d417034289f8e",
                    "additional_price": 0.0,
                    "cls": "IBProductsKitBundleItem"
                  },
                  {
                    "data": "562ad269072d41703d289f8e",
                    "additional_price": 0.0,
                    "cls": "IBProductsKitBundleItem"
                  },
                  {
                    "data": "562ad2b5072d417040289f8e",
                    "additional_price": 0.0,
                    "cls": "IBProductsKitBundleItem"
                  }
                ],
                "min_choice": 1,
                "id": "70c564f75f394363",
                "name": "hueghf",
                "raise_products_price": false,
                "cls": "IBProductsKitBundle"
              },
              {
                "max_choice": 3,
                "products": [
                  {
                    "data": "562ad1bc072d417034289f8e",
                    "additional_price": 0.0,
                    "cls": "IBProductsKitBundleItem"
                  },
                  {
                    "data": "562ad269072d41703d289f8e",
                    "additional_price": 0.0,
                    "cls": "IBProductsKitBundleItem"
                  },
                  {
                    "data": "562ad2b5072d417040289f8e",
                    "additional_price": 0.0,
                    "cls": "IBProductsKitBundleItem"
                  }
                ],
                "min_choice": 1,
                "id": "fc19a8005f3a4b5d",
                "name": "teste",
                "raise_products_price": false,
                "cls": "IBProductsKitBundle"
              }
            ]
          }
        ]
      },
      {
        "id": "562aceda072d41701c289f8e",
        "title": "Bolsas e Acessórios",
        "slug": "Bolsas-e-Acessorios",
        "items": [
          {
            "variation_items": [
              
            ],
            "id": "5cc8a33cc081167efbd6c079",
            "available_stock": true,
            "name": "Óleo de Soja SOYA 900ml",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "0bea649353244ef0",
                "title": "default",
                "internal_code": "27",
                "bar_codes": [
                  
                ],
                "price": 10.0,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Oleo-de-Soja-SOYA-900ml",
            "custom_infos": [
              
            ],
            "min_price_valid": 10.0,
            "copy_of": "5cc89f6fbda3a9141a07381b",
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "Óleo de Soja 900ML Soya.",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Soya",
            "related_items": [
              
            ],
            "images": [
              "3295e60489164fa28afd3fab94314257.jpg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "562adc8e072d41708f289f8e"
            ]
          },
          {
            "variation_items": [
              
            ],
            "id": "562add09072d417098289f8e",
            "available_stock": true,
            "name": "Carteira Macadamia Recorte Branca",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "225bc886e9bc4f1a",
                "title": "default",
                "internal_code": "MA318ACF98NGF",
                "bar_codes": [
                  
                ],
                "price": 99.9,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Carteira-Macadamia-Recorte-Branca",
            "custom_infos": [
              
            ],
            "min_price_valid": 99.9,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nCarteira Macadamia Recorte branca, confeccionada em material sintético, com recorte em cor contrastante, dez compartimentos internos, sendo um fechado a zíper e fechamento por encaixe. Mede 20x11x3cm (LXAXP). Interior em material sintético.\r\nINFORMAÇÕES\r\n\r\nSKU \tMA318ACF98NGF\r\nModelo\tMacadâmia MCH06005-02E\r\nMaterial Externo\tSintético\r\nMaterial Interno\tSintético\r\nCor\tBranco\r\nAltura\t11cm\r\nLargura\t20cm\r\nProfundidade\t3cm",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Macadâmia",
            "related_items": [
              
            ],
            "images": [
              "2015102412111709641b29d8692856c495b8803f9aa34fedd20.jpg",
              "2015102412113432536c6037a675c14e648b997a0d34802d0e.jpg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "562adc8e072d41708f289f8e"
            ]
          }
        ]
      },
      {
        "id": "562acde6072d417015289f8f",
        "title": "Roupas Masculinas",
        "slug": "Roupas-Masculinas",
        "items": [
          {
            "variation_items": [
              
            ],
            "id": "5c8269818050c003e084fdbd",
            "available_stock": true,
            "name": "CAMISETA REGULAR LISTRADA",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "fa0d3d8dac9b4afb",
                "title": "default",
                "internal_code": "024789-8",
                "bar_codes": [
                  "7892840268244"
                ],
                "price": 19.9,
                "qtd_stock": 2.0
              },
              {
                "cls": "IBItemPrice",
                "id": "74b56f3158a54c41",
                "title": "teste",
                "internal_code": "osdkfdos",
                "bar_codes": [
                  "oskfodfk"
                ],
                "price": 125.0,
                "qtd_stock": 0.0
              }
            ],
            "slug": "CAMISETA-REGULAR-LISTRADA",
            "custom_infos": [
              
            ],
            "min_price_valid": 19.9,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.01,
              "deliverable": true
            },
            "description": "<ul style=\"margin: 10px 0px; padding: 0px; outline: none; list-style: initial; color: rgb(145, 145, 145); font-family: Lato, sans-serif; font-size: 12px; letter-spacing: normal;\"><li style=\"margin: 0px; padding: 0px 0px 0px 15px; outline: none; position: relative; border: 0px; list-style-type: disc !important;\">Camiseta masculina</li><li style=\"margin: 0px; padding: 0px 0px 0px 15px; outline: none; position: relative; border: 0px; list-style-type: disc !important;\">Manga curta</li><li style=\"margin: 0px; padding: 0px 0px 0px 15px; outline: none; position: relative; border: 0px; list-style-type: disc !important;\">Modelo: Regular</li><li style=\"margin: 0px; padding: 0px 0px 0px 15px; outline: none; position: relative; border: 0px; list-style-type: disc !important;\">Gola redonda</li><li style=\"margin: 0px; padding: 0px 0px 0px 15px; outline: none; position: relative; border: 0px; list-style-type: disc !important;\">Listrada</li><li style=\"margin: 0px; padding: 0px 0px 0px 15px; outline: none; position: relative; border: 0px; list-style-type: disc !important;\">Marca: Marfinno</li><li style=\"margin: 0px; padding: 0px 0px 0px 15px; outline: none; position: relative; border: 0px; list-style-type: disc !important;\">Tecido: meia malha</li><li style=\"margin: 0px; padding: 0px 0px 0px 15px; outline: none; position: relative; border: 0px; list-style-type: disc !important;\">Composição: 100% algodão</li></ul><p style=\"margin-top: 10px; margin-bottom: 10px; outline: none; line-height: 18px; color: rgb(145, 145, 145); font-family: Lato, sans-serif; font-size: 12px; letter-spacing: normal;\">&nbsp;</p><p style=\"margin-top: 10px; margin-bottom: 10px; outline: none; line-height: 18px; color: rgb(145, 145, 145); font-family: Lato, sans-serif; font-size: 12px; letter-spacing: normal;\"><span style=\"margin: 0px; padding: 0px; outline: none; font-weight: bolder;\">Medidas do Modelo:</span></p><p style=\"margin-top: 10px; margin-bottom: 10px; outline: none; line-height: 18px; color: rgb(145, 145, 145); font-family: Lato, sans-serif; font-size: 12px; letter-spacing: normal;\">&nbsp;</p><p style=\"margin-top: 10px; margin-bottom: 10px; outline: none; line-height: 18px; color: rgb(145, 145, 145); font-family: Lato, sans-serif; font-size: 12px; letter-spacing: normal;\">Altura; 1,84</p><p style=\"margin-top: 10px; margin-bottom: 10px; outline: none; line-height: 18px; color: rgb(145, 145, 145); font-family: Lato, sans-serif; font-size: 12px; letter-spacing: normal;\">Tórax: 95</p><p style=\"margin-top: 10px; margin-bottom: 10px; outline: none; line-height: 18px; color: rgb(145, 145, 145); font-family: Lato, sans-serif; font-size: 12px; letter-spacing: normal;\">Manequim: 40</p><p style=\"margin-top: 10px; margin-bottom: 10px; outline: none; line-height: 18px; color: rgb(145, 145, 145); font-family: Lato, sans-serif; font-size: 12px; letter-spacing: normal;\">Sapatos: 43</p><p style=\"margin-top: 10px; margin-bottom: 10px; outline: none; line-height: 18px; color: rgb(145, 145, 145); font-family: Lato, sans-serif; font-size: 12px; letter-spacing: normal;\">Terno: 50</p><p style=\"margin-top: 10px; margin-bottom: 10px; outline: none; line-height: 18px; color: rgb(145, 145, 145); font-family: Lato, sans-serif; font-size: 12px; letter-spacing: normal;\">Camisa: 03</p><p style=\"margin-top: 10px; margin-bottom: 10px; outline: none; line-height: 18px; color: rgb(145, 145, 145); font-family: Lato, sans-serif; font-size: 12px; letter-spacing: normal;\">&nbsp;</p><p style=\"margin-top: 10px; margin-bottom: 10px; outline: none; line-height: 18px; color: rgb(145, 145, 145); font-family: Lato, sans-serif; font-size: 12px; letter-spacing: normal;\"><span style=\"margin: 0px; padding: 0px; outline: none; font-weight: bolder;\">COLEÇÃO PRIMAVERA VERÃO 2019</span></p>",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Renner",
            "related_items": [
              
            ],
            "images": [
              "c4c60ea191aa4e79a1e4e86d2e8b7aff.jpeg",
              "678575a77eff405a91abbe92366dbf39.jpeg"
            ],
            "item_type": "product",
            "subcategory_ids": [
              "5c8268518050c003df84f54c"
            ]
          },
          {
            "variation_items": [
              "562ad269072d41703d289f8e",
              "562ad1bc072d417034289f8e"
            ],
            "id": "562addf0072d41709b289f8f",
            "available_stock": true,
            "name": "Bermuda Sarja Reserva Army Básica",
            "prices": [
              {
                "cls": "IBItemPrice",
                "id": "200749d4cc814f12",
                "title": "default",
                "internal_code": "RE499APM49PRQDB",
                "bar_codes": [
                  "7892840268046"
                ],
                "price": 90.15,
                "qtd_stock": -1.0
              }
            ],
            "slug": "Bermuda-Sarja-Reserva-Army-Basica",
            "custom_infos": [
              {
                "value": "39cm",
                "field": "5b928eb4017ce27d51863aef",
                "cls": "IBItemCustomInfo"
              }
            ],
            "min_price_valid": 90.15,
            "shipping": {
              "width": 1.0,
              "processing_days": 0,
              "height": 1.0,
              "length": 1.0,
              "cls": "IBProductShipping",
              "weight": 0.5,
              "deliverable": true
            },
            "description": "DETALHES DO PRODUTO\r\n\r\nBermuda Sarja Reserva Army Básica Verona preta, com quatro bolsos e bordado da marca localizado. Tem modelagem reta, gancho médio e cinco passantes no cós. \r\n\r\nConfeccionada em sarja macia. Fechamento por zíper e botão. Acompanha cinto.\r\n\r\nCintura: 86cm/ Quadril: 104cm/ Gancho: 22cm/ Comprimento: 52cm/ Tamanho: 40. \r\n\r\nMedidas do Modelo: Altura 1,88m / Tórax 94cm / Manequim 40.\r\nINFORMAÇÕES\r\n\r\nSKU \tRE499APM49PRQ\r\nModelo\tReserva 1553\r\nMaterial\tAlgodão\r\nComposição\t100% Algodão\r\nCor\tPreto\r\nLavagem\tPode ser lavado na máquina",
            "unit_type": "UNI",
            "increment_value": 1.0,
            "brand": "Reserva 2",
            "related_items": [
              
            ],
            "images": [
              "2015102412525016200d8ac27ff0344a8db2fb3a59faa7d513.jpg",
              "2015102412539650503f10e3528dbe46bb92826701b088e52d.jpg"
            ],
            "attachment": "https://s3-sa-east-1.amazonaws.com/ib.files.general/a809ad71339a4c808696243534350a09.jpg",
            "item_type": "product",
            "subcategory_ids": [
              "562add93072d41709b289f8e",
              "562ad0e4072d41701b289f8f",
              "562ad4f5072d417049289f8e"
            ]
          }
        ]
      }
    ]
  },
  "status": "success",
  "count": 0,
  "http_status": 200
}
```

### HTTP Request
`GET /layout`


# Login
This API allow you to login user.

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
`POST /login`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`email` | string | required | User email.
`password` | string | required | User password.


# Logout
This API allow you to logout user.

> JSON response example:

```json
{  
   "data":"ok",
   "status":"success",
   "count":0,
   "http_status":200
}
```

### HTTP Request
`DELETE /logout`


# Menu
This API allow you to get the store categories menu.

## Menu properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`data` | array |	List of Categories. See [Category properties](#menu-category-properties).

## Menu Category properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`title` | string | The subcategory title.
`show_order` | integer | In what position it should appear on menu.
`slug` | string | Category slug.
`meta_title` | string | Category's html meta title.
`meta_description` | string | Category's html meta description.
`sub_categories` | array | List of subcategories. See [Subcategory properties](#menu-subcategory-properties).

## Menu Subcategory properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`title` | string | The subcategory title.
`category_id` | object | Category Data. See [Category properties](#menu-category-properties).

## Get menu
This API helps you to view all the categories and subcategories.

> JSON response example:

```json
{
  "data": [
    {
      "title": "Cestas ",
      "slug": "Cestas",
      "show_order": 999,
      "id": "580e64c2072d413c368f3ecf",
      "sub_categories": [
        {
          "title": "Cestas",
          "category_id": "580e64c2072d413c368f3ecf",
          "id": "580e64cc072d413c398f3ecf"
        }
      ]
    },
    {
      "title": "Minha Seleção",
      "slug": "Minha-Selecao",
      "show_order": 999,
      "id": "57eec903072d415b5bc24175",
      "sub_categories": [
        {
          "title": "Frutas",
          "category_id": "57eec903072d415b5bc24175",
          "id": "57eec92a072d415b63c24175"
        },
        {
          "title": "Legumes",
          "category_id": "57eec903072d415b5bc24175",
          "id": "57eec92f072d415b67c24175"
        },
        {
          "title": "Leguminosas",
          "category_id": "57eec903072d415b5bc24175",
          "id": "580dffa2072d412535accdc7"
        },
        {
          "title": "Outros",
          "category_id": "57eec903072d415b5bc24175",
          "id": "580e5c6e072d413a10accdc7"
        },
        {
          "title": "Temperos",
          "category_id": "57eec903072d415b5bc24175",
          "id": "580e1b6f072d412810accdc7"
        },
        {
          "title": "Tubérculos",
          "category_id": "57eec903072d415b5bc24175",
          "id": "580dff95072d412532accdc7"
        },
        {
          "title": "Verduras",
          "category_id": "57eec903072d415b5bc24175",
          "id": "57eec93e072d415b70c24175"
        }
      ]
    }
  ],
  "status": "success",
  "count": 0,
  "http_status": 200
}
```

### HTTP Request
`GET /menu`


# Newsletter
This API allows you to register email in newsletter.

> JSON response example:

```json
{  
   "data":"ok",
   "status":"success",
   "count":0,
   "http_status":200
}
```

### HTTP Request
`POST /newsletter`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`email` | string | required | Client email.


# Search
The items API allows you to list items(products and products kits) based on a search text that will consider items name and description or a search by barcode.

> JSON response example:

```json
{
  "data": [
    {
      "custom_infos": [
        {
          "field": "5b929009017ce27d51863b51",
          "value": "12%",
          "cls": "IBItemCustomInfo"
        },
        {
          "field": "5b929007017ce27d51863b4e",
          "value": " Ideal para acompanhar pratos de carne branca, aves e peixes assados ou grelhados, frutos do mar e crustáceos. Também apreciado com bolos e sobremesas.",
          "cls": "IBItemCustomInfo"
        },
        {
          "field": "5b929008017ce27d51863b50",
          "value": "40% Pinot noir, 40% Chardonnay e 20% Pinot Meunier",
          "cls": "IBItemCustomInfo"
        },
        {
          "field": "5b92900a017ce27d51863b53",
          "value": "França",
          "cls": "IBItemCustomInfo"
        }
      ],
      "name": "Louis Roederer Premier Brut Wooden Box 3lt",
      "increment_value": 1.0,
      "subcategory_ids": [
        "5bf4436f063e6409e4de43b9"
      ],
      "prices": [
        {
          "internal_code": "9914",
          "cls": "IBItemPrice",
          "id": "8ec0f4ce648d460d",
          "bar_codes": [
            
          ],
          "title": "default",
          "price": 2795.58,
          "qtd_stock": 1.0
        }
      ],
      "unit_type": "UNI",
      "description": "<h6><font color=\"#666666\" face=\"Proxima Nova, -apple-system, Helvetica Neue, Helvetica, Roboto, Arial, sans-serif\"><span style=\"font-size: 20px;\">Brut Premier é um champanhe harmonioso e estruturado, elegante, com uma exuberância única. No paladar, sua textura é rica, e comprimento distintamente avinhado. É um complexo vinho, ricos e poderosos, mantendo-se um grande clássico. Estagiou em tonéis de carvalho produzidos a partir de três variedades de uva de Champagne que se originam de várias crus selecionados por Louis Roederer. É envelhecido por 3 anos nas caves de Louis Roederer.</span></font><br></h6>",
      "min_price_valid": 2795.58,
      "available_stock": true,
      "store_id": "5a0056697058f5383127a0aa",
      "shipping": {
        "cls": "IBProductShipping",
        "length": 1.0,
        "height": 1.0,
        "width": 1.0,
        "weight": 1.2,
        "processing_days": 0,
        "deliverable": true
      },
      "id": "5bf2eb40063e640565de43b9",
      "qtd_sold": 0.0,
      "visible": true,
      "slug": "Louis-Roederer-Premier-Brut-Wooden-Box-3-Litros",
      "brand": "Louis Roederer",
      "images": [
        "2ae5007f439141f88a9e7fcc1a005690.png"
      ],
      "variation_items": [
        
      ],
      "related_items": [
        
      ],
      "item_type": "product"
    },
    {
      "custom_infos": [
        {
          "field": "5b92900a017ce27d51863b53",
          "value": "França",
          "cls": "IBItemCustomInfo"
        },
        {
          "field": "5b929008017ce27d51863b4f",
          "value": "Louis Roederer",
          "cls": "IBItemCustomInfo"
        },
        {
          "field": "5b929008017ce27d51863b50",
          "value": "Pinot Noir e Chardonnay",
          "cls": "IBItemCustomInfo"
        },
        {
          "field": "5b929009017ce27d51863b51",
          "value": " 12%",
          "cls": "IBItemCustomInfo"
        },
        {
          "field": "5b92a3a0017ce282c2845011",
          "value": "Disponível nas Safras 2006, 2007 e 2009.",
          "cls": "IBItemCustomInfo"
        }
      ],
      "name": "Cristal Brut Louis Roederer 2007 e 2009  750ml",
      "increment_value": 1.0,
      "subcategory_ids": [
        "5bf4436f063e6409e4de43b9",
        "5ca4d2b48050c003fa37b891"
      ],
      "prices": [
        {
          "internal_code": "3461",
          "cls": "IBItemPrice",
          "id": "52b6b538f69840a7",
          "promo_end_at": "2019-05-31T02:59:59+00:00",
          "bar_codes": [
            "3114080043059"
          ],
          "title": "default",
          "price": 2004.47,
          "promo_price": 1703.8,
          "qtd_stock": 24.0
        }
      ],
      "unit_type": "UNI",
      "description": "Cobiçado no mundo todo, o champagne Cristal foi criado em 1876 a pedido do czar Alexandre II, notório apaixonado pelos vinhos da maison Louis Roederer. É um marco também por ter inaugurado uma nova categoria: a Cuvée de Prestige, sendo elaborado apenas em anos excepcionais. Para criar um champagne ao gosto do exigente czar, Louis Roederer empreendeu uma seleção rigorosa das melhores uvas de seus Grands Crus. O Cristal 2007 é um charmoso corte com 58% de Pinot Noir e 42% de Chardonnay, sendo 15% dos vinhos maturados em carvalho, com batonnage semanal. Não há fermentação malolática para preservar o ótimo frescor. Este champagne maturou 5 anos nas caves, sendo 8 meses depois do disgorgement. O resultado é um borbulhante que expressa a distinção de seu terroir.  Com bolhas impecavelmente finas, regulares e constantes. O ataque na boca remete a frutas brancas maduras, como pera, além frutas vermelhas ácidas e nuances de padaria, como de Tarte Tatin recém saída do forno. Toques de mineralidade surgem na ponta da língua. É um champagne concentrado, com textura aveludada e grande profundidade. No nariz, são evidentes os aromas de chocolate e avelã, conferidos pela fermentação em carvalho de parte dos vinhos dessa safra. Cristal 2007 é um exemplo máximo de finesse.",
      "min_price_valid": 1703.8,
      "available_stock": true,
      "store_id": "5a0056697058f5383127a0aa",
      "shipping": {
        "cls": "IBProductShipping",
        "length": 1.0,
        "height": 1.0,
        "width": 1.0,
        "weight": 1.25,
        "processing_days": 0,
        "deliverable": true
      },
      "id": "5b056b8f94e42951ad78d67e",
      "qtd_sold": 0.0,
      "visible": true,
      "slug": "Cristal-Brut-Louis-Roederer-2007-750ml",
      "brand": "Louis Roederer",
      "images": [
        "83cdb550dd564ec5bc7f79d2c43e8df7.jpg"
      ],
      "variation_items": [
        
      ],
      "related_items": [
        
      ],
      "item_type": "product"
    }
  ],
  "status": "success",
  "count": 14,
  "http_status": 200
}
``` 

### HTTP Request
`GET /search`

#### Available parameters
Parameter | Type | Description
-------------- | -------------- | -------------- 
`search` | string | Search for items with name or description containing `search` text.
`search_code` | string | Search for item that contains barcode or PLU equal `search_code`.


# Store
This API allows you to get store info.

## Store properties

Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`subdomain`| string | Store subdomain
`custom_domain` | string | Store custom domain.
`address` | object | Store address. See [Address](#address).
`reviews_count` | integer | Number of buys reviewed.
`delivery_time` | integer | Total note for delivery_time. Split with `reviews_count` to get average.
`practicality` | integer | Total note for practicality. Split with `reviews_count` to get average.
`practicality` | integer | Total note for practicality. Split with `reviews_count` to get average.
`average_review` | float | Average review note.
`spatial_position` | object | Store spatial position.
`opening_hours` | object | Store functioning hours. See [Opening Hour](#store-opening-hour-properties).
`phone` | string | Store contact phone.
`make_collect` | boolean | If client can fetch the order in the physical store.
`slogan` | string | Store slogan.
`favicon`| string | Browser favicon image key.
`social_links` | object | Store social links. See [Social Links](#store-social-links-properties).
`make_delivery` | boolean | If store deliveries buys to client house.
`description` | string | Store description text.
`accepted_pos_cards` | array | List with POS cards accepted. See [POS Card](#store-pos-card-properties).
`logo` | string | Store logo image key.
`schedules_buys` | boolean | If user should schedule buy receiptment.
`money_payment` | boolean | If Store accepts cash payment.
`background_image` | string | Store header background image key.
`name` | string | Store name.
`receipt_from` | string | If store doesnt schedules buy, this is the average time to receive the buy.
`make_correios` | boolean | If store send buys to user with Correios.
`min_price_to_finish` | float | Minimum buy subtotal to make a buy.
`pos_payment` | boolean | If store accepts physical credit/debit/vale payment.
`check_payment` | boolean | If stores accepts check payment.
`deposit_payment` | boolean | If Store accepts bank deposit payment.
`pagar_me_credit_card_payment` | boolean | If Store accepts credit payment using Pagar.me gateway.
`pagar_me_billet_payment` | boolean | If store accepts billet payment using Pagar.me gateway.
`cielo_debit_card_payment` | boolean | If Store accepts debit payment using Cielo gateway.
`cielo_credit_card_payment` | boolean | If Store accepts credit payment using Cielo gateway.
`billet_percent_discount` | float | Discount that should be applied to buy subtotal if billet payment.
`installments` | array | List of Installments accepted. See [Installment](#store-installment-properties).

## Store - Opening Hour properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`weekday` | string |	Weekday.
`closed_all_day` | boolean | If store doesnt open this weekday.
`open_all_day` | boolean | If store is open 24h this weekday.
`open_at` | string | Hour that store opens in this weekday, if not 24 and not closed.
`close_at` | string | Hour that store closes in this weekday, if not 24 and not closed.

## Store - Installment properties
Note that Installment is applied only to credit payment(either online or POS).

Attribute | Type | Description
-------------- | -------------- | -------------- 
`installments_number` | integer |	How many times the payment should be split.
`interest` | float | Interest applied (% per month).
`buy_min_value` | float | Minimum buy value to apply this installment rule.

## Store - Social Links properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`twitter` | string |	Store Twitter URL.
`facebook` | string |	Store Facebook URL.
`instagram` | string |	Store Instagram URL.
`whatsapp` | string |	Store Whatsapp phone number.

## Store - POS Card properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`is_credit` | string |	If accepts credit with this card flag.
`is_debit` | string |	If accepts debit with this card flag.
`is_vale` | string |	If accepts vale with this card flag.
`card_data.id` | string |	Unique identifier for the resource.
`card_data.image` | string |	Card flag image key.
`card_data.flag` | string |	Card flag.


## Retrieve store
Retrieve store infos.

> JSON response example:

```json
{
  "data": {
    "reviews_count": 1,
    "address": {
      "zipcode": "70278-020",
      "street": "Quadra SQS 412 Bloco B",
      "street_number": "huezin",
      "complement": "",
      "city": "Brasília",
      "neighborhood": "Asa Sul",
      "state": "DF"
    },
    "delivery_time": 5,
    "spatial_position": {
      "type": "Point",
      "coordinates": [
        -47.8731722249,
        -15.7770631343
      ]
    },
    "fast_buy": false,
    "pagarme_billet_payment": true,
    "opening_hours": [
      {
        "closed_all_day": false,
        "close_at": "17:00",
        "open_at": "10:00",
        "weekday": "monday",
        "open_all_day": false
      },
      {
        "closed_all_day": true,
        "close_at": "17:00",
        "open_at": "10:00",
        "weekday": "tuesday",
        "open_all_day": false
      },
      {
        "closed_all_day": true,
        "close_at": "17:00",
        "open_at": "10:00",
        "weekday": "friday",
        "open_all_day": false
      },
      {
        "closed_all_day": true,
        "close_at": "21:00",
        "open_at": "08:00",
        "weekday": "wednesday",
        "open_all_day": false
      },
      {
        "closed_all_day": false,
        "close_at": "21:00",
        "open_at": "08:00",
        "weekday": "thursday",
        "open_all_day": true
      },
      {
        "closed_all_day": true,
        "close_at": "",
        "open_at": "",
        "weekday": "sunday",
        "open_all_day": false
      },
      {
        "closed_all_day": true,
        "close_at": "",
        "open_at": "",
        "weekday": "saturday",
        "open_all_day": false
      }
    ],
    "services": [
      "55becfc81080907415e9c3ff"
    ],
    "practicality": 5,
    "phone": "(61) 99161-3871",
    "average_review": 4,
    "id": "55c17d73072d4126ea180fe5",
    "pos_payment": true,
    "make_collect": true,
    "slogan": "Faça a sua moda!",
    "favicon": "53f4223c238c4b43a7731672ff43cc6c.jpeg",
    "check_payment": true,
    "installments": [
      {
        "installments_number": 3,
        "interest": 0.0,
        "buy_min_value": 0.0
      },
      {
        "installments_number": 4,
        "interest": 0.0,
        "buy_min_value": 100.0
      },
      {
        "installments_number": 7,
        "interest": 10.0,
        "buy_min_value": 60.0
      }
    ],
    "billet_percent_discount": 5.0,
    "social_links": {
      "twitter": "http://twitter.com",
      "google_plus": "huebr",
      "facebook": "https://www.facebook.com/instabuy",
      "instagram": "https://www.instagram.com/instabuy_brasil/",
      "whatsapp": "61999999999"
    },
    "make_delivery": true,
    "description": "Ultimas tendencias da moda masculina e feminina.",
    "deposit_payment": false,
    "items_quality": 3,
    "accepted_pos_cards": [
      {
        "is_credit": true,
        "card_data": {
          "image": "mastercard.png",
          "id": "5b5e733c017ce2a4dff1b1ea",
          "flag": "MasterCard"
        },
        "is_debit": true,
        "is_vale": false
      },
      {
        "is_credit": true,
        "card_data": {
          "image": "visa.png",
          "id": "5b5e733b017ce2a4dff1b1e9",
          "flag": "Visa"
        },
        "is_debit": true,
        "is_vale": false
      },
      {
        "is_credit": true,
        "card_data": {
          "image": "elo.png",
          "id": "5b5e733c017ce2a4dff1b1ec",
          "flag": "Elo"
        },
        "is_debit": true,
        "is_vale": false
      }
    ],
    "logo": "830a066682c14b669332fc62630643cd.jpeg",
    "cielo_debit_card_payment": false,
    "subdomain": "caykestore",
    "schedules_buys": true,
    "money_payment": true,
    "background_image": "201703132154372425607186760145844a4c84fe25abe4260db1.jpg",
    "name": "Vitrini Store",
    "schedule_days": [
      {
        "weekday": "sunday",
        "hours": [
          {
            "setup_time": 60,
            "id": "dbc81",
            "end_time": "12:00",
            "start_time": "08:00"
          },
          {
            "setup_time": 20,
            "id": "39613",
            "end_time": "19:00",
            "start_time": "05:00"
          },
          {
            "setup_time": 45,
            "id": "ayOtf2Tc",
            "end_time": "18:00",
            "start_time": "06:00"
          },
          {
            "setup_time": 0,
            "id": "3tI45sjE",
            "end_time": "18:00",
            "start_time": "14:00"
          }
        ]
      },
      {
        "weekday": "monday",
        "hours": [
          {
            "setup_time": 10,
            "id": "aa24e",
            "end_time": "13:00",
            "start_time": "07:00"
          },
          {
            "setup_time": 10,
            "id": "0232d",
            "end_time": "18:00",
            "start_time": "14:00"
          },
          {
            "setup_time": 90,
            "id": "TnRVf9Od",
            "end_time": "15:00",
            "start_time": "13:30"
          },
          {
            "setup_time": 240,
            "id": "ytt9u6vs",
            "end_time": "11:00",
            "start_time": "06:00"
          }
        ]
      },
      {
        "weekday": "tuesday",
        "hours": [
          {
            "setup_time": 10,
            "id": "c88ed",
            "end_time": "17:30",
            "start_time": "13:00"
          }
        ]
      },
      {
        "weekday": "wednesday",
        "hours": [
          {
            "setup_time": 10,
            "id": "57dbc",
            "end_time": "11:00",
            "start_time": "09:30"
          },
          {
            "setup_time": 10,
            "id": "ac410",
            "end_time": "20:30",
            "start_time": "14:00"
          }
        ]
      },
      {
        "weekday": "thursday",
        "hours": [
          {
            "setup_time": 10,
            "id": "a596c",
            "end_time": "08:00",
            "start_time": "06:00"
          },
          {
            "setup_time": 10,
            "id": "d479d",
            "end_time": "13:00",
            "start_time": "09:30"
          },
          {
            "setup_time": 10,
            "id": "81701",
            "end_time": "21:00",
            "start_time": "16:00"
          }
        ]
      },
      {
        "weekday": "friday",
        "hours": [
          {
            "setup_time": 10,
            "id": "851fe",
            "end_time": "15:30",
            "start_time": "08:00"
          },
          {
            "setup_time": 10,
            "id": "5361b",
            "end_time": "20:00",
            "start_time": "17:00"
          }
        ]
      },
      {
        "weekday": "saturday",
        "hours": [
          {
            "setup_time": 10,
            "id": "771ee",
            "end_time": "13:30",
            "start_time": "10:00"
          }
        ]
      }
    ],
    "cielo_credit_card_payment": false,
    "receipt_from": "50min - 1h10min",
    "make_correios": false,
    "min_price_to_finish": 4.0,
    "pagarme_credit_card_payment": true
  },
  "status": "success",
  "count": 1,
  "http_status": 200
}
```

### HTTP Request
`GET /store`


# User
This API allows you to create, edit and get users.

## User properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`email` | string | User email.
`phone` | string | User phone.
`user_type` | string | User type. If `PF` see [UserPF](#userpf-properties), if `PJ` see [UserPJ](#userpj-properties).
`cards` | array | List of credit cards. See [Card](#card-properties).
`addresses` | array | List of addresses | See [Address](#address-properties).

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
This API allows you to get the logged user.

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

## Create User
This API allows you to create new User.

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
`POST /user`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`email` | string | required | User email.
`password` | string | required | User password.
`phone` | string | required | User phone.
`first_name` | string | required for PF | User first name.
`last_name` | string | required for PF | User last name.
`gender` | string | required for PF | User gender. `F` or `M`.
`birthday` | string | required for PF | User birthday. `DD/MM/YYYY` format.
`cpf` | string | required for PF | User CPF.
`company_name` | string | required for PJ | User company name.
`fantasy_name` | string | required for PJ | User fantasy name.
`cnpj` | string | required for PJ | User CNPJ.

## Edi User
This API allows you to edit User info.

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
`PUT /user`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`phone` | string | required | User phone.
`first_name` | string | required for PF | User first name.
`last_name` | string | required for PF | User last name.
`gender` | string | required for PF | User gender. `F` or `M`.
`birthday` | string | required for PF | User birthday. `DD/MM/YYYY` format.
`cpf` | string | required for PF | User CPF.
`company_name` | string | required for PJ | User company name.
`fantasy_name` | string | required for PJ | User fantasy name.
`cnpj` | string | required for PJ | User CNPJ.

# User Password
This API allows you to change user password with different methods.

## Change with actual password
This API replaces the logged user password if password matches to actual password.

> JSON response example:

```json
{  
   "data":"ok",
   "status":"success",
   "count":0,
   "http_status":200
}
``` 

### HTTP Request
`PUT /user`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`password` | string | required | User actual password.
`new_password` | string | required | User new password.

## Generate Token 
This API generates token and send it to user email.

> JSON response example:

```json
{  
   "data":"ok",
   "status":"success",
   "count":0,
   "http_status":200
}
``` 

### HTTP Request
`POST /forgotpassword`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`email` | string | required | User email.
`landing_domain` | string | required | To what URL the email sent to user should redirect. The token will be append in the end of this URL.


## Change Password with Token
Changes User password using Token send to email.

> JSON response example:

```json
{  
   "data":"ok",
   "status":"success",
   "count":0,
   "http_status":200
}
``` 

### HTTP Request
`POST /change_password`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`password` | string | required | New password.
`token` | string | required | Token send to user email.
