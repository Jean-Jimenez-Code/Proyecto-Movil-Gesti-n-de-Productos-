const prodSchema = require('../models/product.model')

const postProduct=async (req,res)=>{
    const nom = req.body.nom;

    const product = await prodSchema.deleteOne({ nombre:nom });
    res.json(product)     
}


module.exports={postProduct}