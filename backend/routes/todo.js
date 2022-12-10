var express = require('express');
var router = express.Router();
const {getProducts,postProduct} = require('../controller/product.controller')


router.get('/product',getProducts)

router.post('/product',postProduct)

module.exports = router;