const fs
  = require("fs");

let inputFile = process.argv[2];
let outputFile = process.argv[3];

const input = `var $author$project$Html$LazyExtra$lazyShallow = F2(
\tfunction (func, a) {
\t\treturn func(a);
\t});`;

const replacement = `
var $author$project$Html$LazyExtra$lazyShallow = F2(function(func, record)
{
  var args = [func];
  for (var key in record)
  {
    args.push(record[key]);
  }
  return _VirtualDom_thunk(
    args,
    function() {
      return func(record);
    }
  );
});`;


if (!inputFile || !outputFile) {
    console.error("You must specify an input and output file");
    process.exit(1);
}

// WRITE THE PATCHES

const patchedFile = fs
    .readFileSync(inputFile)
    .toString()
    .replace(input, replacement);

fs.writeFileSync(outputFile, patchedFile);