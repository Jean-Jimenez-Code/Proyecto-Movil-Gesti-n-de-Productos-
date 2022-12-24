var express = require('express');
var router = express.Router();
const {postProduct} = require('../controller/borrar.controller')

router.post('/product',postProduct)





module.exports = router;