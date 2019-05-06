---
title: API Reference

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
---

# Introduction

Welcome to Instabuy's **REST** Client API. This API allows you to provide functions and data to your e-commerce website/app, like products, categories, carts, buys, etc.

<aside class="warning">This documentation is in construction. If you find any error or have doubts, please mail me at cayke@instabuy.com.br</aside>

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


# User Password
This API allows you to change user password with different methods.

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
