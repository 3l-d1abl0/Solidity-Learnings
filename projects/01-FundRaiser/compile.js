const path = require('path');
const fs = require('fs');
const solc = require('solc');


const inboxPath = path.resolve(__dirname, 'contracts', 'FundRaiser.sol');

console.log(`Compiling ${inboxPath}...`);

const source = fs.readFileSync(inboxPath, 'utf8');

//console.log(solc.compile(source, 1));

var input = {
    language: 'Solidity',
    sources: {
        'FundRaiser.sol': {
            content: source
        }
    },
    settings: {
        optimizer:
        {
            enabled: true
        },
        outputSelection: {
            '*': {
                '*': ['*']
            }
        }
    }
};

//console.log(JSON.parse(solc.compile(JSON.stringify(input)), 1).contracts['FundRaiser.sol']);
const output = JSON.parse(solc.compile(JSON.stringify(input)), 1).contracts['FundRaiser.sol'];

//console.log(output);

const interface = output.FundRaising.abi;
const bytecode = output.FundRaising.evm.bytecode.object;

/*console.log(interface);
console.log(bytecode);*/

console.log('Done compiling !');
module.exports = {
    interface,
    bytecode,
};