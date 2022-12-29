const prodSchema = require('../models/product.model')//traemos el modelo de la carpeta models que tendria los elementos de la base de datos

const postProduct=async (req,res)=>{
    const nom = req.body.nom;//resivimos el elemento

    const product = await prodSchema.deleteOne({ nombre:nom });//borramos los datos del elemento resivido
    res.json(product)     
}


module.exports={postProduct}//exportamos 