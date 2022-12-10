const prodSchema = require('../models/product.model')

const getProducts = async(req , res)=>{
    const products=await prodSchema.find()
    console.log('hola')
    console.log(products)

    res.json(products)
}

const postProduct=async (req,res)=>{
       const body =  req.body
       const product = await prodSchema.create(body)
       console.log(product)
       res.json(product)
}
module.exports={getProducts,postProduct}