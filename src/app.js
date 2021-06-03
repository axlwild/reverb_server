const express = require('express');
const app = express();
const { exec } = require("child_process");
const { rejects } = require('assert');
const { resolve } = require('path');
const port = 3005;


app.get('/', (req, res) =>{
    return res.status(200).json({status: "OK", message: "all good :)"});
});

app.listen(port, async () => {
    console.log(`Listen port ${port}`);
    response = await new Promise((res, rej) => {
        exec('python3 /src/hello.py', (error, stdout, stderr) =>{
            if(error) return rej(error);
            return res(stdout);
        });
    });
    console.log({response});
});