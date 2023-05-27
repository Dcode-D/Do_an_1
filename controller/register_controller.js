const bcrypt = require("bcrypt");
const usermodel = require("../models/user_model");
const register_controller= async (req,res)=>{
    const {username,password,gender,email,firstname,lastname,address,phonenumber} = req.body;
    const emailregex = new RegExp("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");
    const phoneregex = new RegExp("([\\D]+)");
    if(!email||!emailregex.test(email)){
        return res.status(503).json({"message":"Bad email"});
    }
    if(!phonenumber||phoneregex.test(phonenumber)){
        return  res.status(503).json({"message":"Bad phone number"});
    }
    if(!password||password.length<8){
        return  res.status(503).json({"message":"Password too short"});
    }
    const hashedpassword = await bcrypt.hash(password,10);
    const model = new usermodel({
        username:username,
        password:hashedpassword,
        gender:gender,
        email:email,
        firstname:firstname,
        lastname:lastname,
        address:address,
        phonenumber:phonenumber
    })
    try {
        const result = await model.save();
        return res.status(200).json({"message":result._id})
    }catch (err){
        if(err)
            console.log(err.message)
            return res.status(503).json({"message":err.message})
    }
}

module.exports = register_controller