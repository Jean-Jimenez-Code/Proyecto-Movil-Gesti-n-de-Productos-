const { Schema, model } = require('mongoose');
const { Buffer } = require('buffer');

const ProdSchema = new Schema( //se asignara los atributos a las variables
  {
    nombre: {//nombre del atributo
      type: String, 
      //string osea que guardara los datos tipo texto
    },
    cantidad: {
      type: String,
    },
    precio: {
        type: String,
    },
    imagen:{
       type:String,
    } 
  },
  { timestamps: true },
);

module.exports= model('prodSchema',ProdSchema)//exportamos los elementos de ProdSchema con el nombre de prodSchema