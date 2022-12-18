const prodSchema = require('../models/product.model')


const getProducts = async(req , res)=>{
    const products=await prodSchema.find()
    console.log('hola')
    console.log(products)
    res.json({list:products})
}

const postProduct=async (req,res)=>{
    const item =  req.body;
    const product = await prodSchema.create(item)
       
    res.json(product)     
}
module.exports={getProducts,postProduct}