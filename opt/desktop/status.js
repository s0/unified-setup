const fs = require('fs');

setInterval(() => {

    const status = [];

    const date = new Date();
    status.push({
        full_text: date.toLocaleString()
    });

    const wstream = fs.createWriteStream('/tmp/status_fifo')
    wstream.write(JSON.stringify(status));
    wstream.end();

}, 500);
