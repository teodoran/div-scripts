var connect = require('connect'),
    serveStatic = require('serve-static');

console.log('Presentation starting at port 1704');
console.log(__dirname);
connect().use(serveStatic(__dirname)).listen(1704);