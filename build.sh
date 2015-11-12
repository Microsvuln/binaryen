echo "building binaryen shell"
g++ -O2 -std=c++11 src/binaryen-shell.cpp -g -o bin/binaryen-shell
echo "building asm2wasm"
g++ -O2 -std=c++11 src/asm2wasm-main.cpp src/emscripten-optimizer/parser.cpp src/emscripten-optimizer/simple_ast.cpp src/emscripten-optimizer/optimizer-shared.cpp -g -o bin/asm2wasm
echo "building interpreter/js"
em++ -std=c++11 src/wasm-js.cpp src/emscripten-optimizer/parser.cpp src/emscripten-optimizer/simple_ast.cpp src/emscripten-optimizer/optimizer-shared.cpp -o bin/wasm.js -s MODULARIZE=1 -s 'EXPORT_NAME="WasmJS"' --memory-init-file 0 -s DEMANGLE_SUPPORT=1 -O3 -profiling -s TOTAL_MEMORY=67108864 -s SAFE_HEAP=1 -s ASSERTIONS=1 #-DWASM_JS_DEBUG #-DWASM_INTERPRETER_DEBUG
cat src/js/post.js >> bin/wasm.js

