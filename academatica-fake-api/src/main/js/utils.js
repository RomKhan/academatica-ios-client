const { readFileSync } = require("node:fs");

const getRandomInt = (min, max) => {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min) + min);
}

const readJson = (path) => JSON.parse(readFileSync(path).toString());

module.exports = {
    getRandomInt,
    readJson
};