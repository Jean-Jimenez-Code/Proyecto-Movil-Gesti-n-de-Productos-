var express = require('express');
var router = express.Router();
const {postProduct} = require('../controller/borrar.controller')//enviamos el postProduct a la carpeta controller al archivo borrar

router.post('/product',postProduct)//hacemos un llamado a postProducts





module.exports = router;