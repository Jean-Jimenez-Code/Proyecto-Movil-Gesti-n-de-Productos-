const prodSchema = require('../models/product.model')//traemos el modelo de la carpeta models que tendria los elementos de la base de datos


const getProducts = async(req , res)=>{//de routes, el llamado viene aqui
    const products=await prodSchema.find()//para llamar los datos de prodSchema y guardarlos en la variable products
    console.log(products)//ver los datos por consola
    res.json({list:products})//enviarlos o exportarlos
}

const postProduct=async (req,res)=>{//de routes, el llamado viene aqui
    const item =  req.body;//resivimos los datos y los guardamos en item
    const product = await prodSchema.create(item)//usamos los datos de item para guardarlos en los atributos de proSchema(que luego se guardaran en la base de datos)      
    res.json(product)//exportamos estos datos     
}
module.exports={getProducts,postProduct}//exportamos postProduct y getProducts