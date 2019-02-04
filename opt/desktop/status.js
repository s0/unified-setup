const fs = require('fs');
const util = require('util');
const exec = util.promisify(require('child_process').exec);

const ACPI_REGEX = /\s([a-zA-Z]+)\, ([0-9]+)\%\, ([^\s]+)\s/;
const COLOR_GREEN = '#86df32'
const COLOR_RED = '#d25252'
const COLOR_BLUE = '#1e90ff'

setInterval(async () => {

    const status = [];

    const batt = (await exec('acpi -b')).stdout;
    const battRegex = ACPI_REGEX.exec(batt);
    if (battRegex) {
        const [_, battStatus, battPercent, battRemaining] = battRegex
        if (battStatus === 'Charging') {
            status.push({
                full_text: `CHARGING: ${battPercent}% (${battRemaining} until full)`,
                color: COLOR_GREEN
            });
        } else {
            const percent = parseInt(battPercent)
            status.push({
                full_text: `${battPercent}% (${battRemaining} remaining)`,
                color: percent < 20 ? COLOR_RED : COLOR_BLUE
            });
        }
    }

    const date = new Date();
    status.push({
        full_text: date.toLocaleString()
    });

    const wstream = fs.createWriteStream('/tmp/status_fifo')
    wstream.write(JSON.stringify(status));
    wstream.end();

}, 500);
