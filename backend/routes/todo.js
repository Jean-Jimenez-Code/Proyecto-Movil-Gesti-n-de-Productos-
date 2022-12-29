var express = require('express');
var router = express.Router();
const {getProducts,postProduct} = require('../controller/product.controller')//enviamos el getProducts y postProduct a la carpeta controller al archivo product


router.get('/product',getProducts)//hacemos un llamado a getProducts

router.post('/product',postProduct)//hacemos un llamado a postProducts

module.exports = router;