#Lab06
```
lab06 % mkdir _build && cd _build 
% cmake .. 
The C compiler identification is AppleClang 17.0.0.17000013 
The CXX compiler identification is AppleClang 17.0.0.17000013 
Detecting C compiler ABI info 
Detecting C compiler ABI info - done 
Check for working C compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc - skipped 
Detecting C compile features 
Detecting C compile features - done 
Detecting CXX compiler ABI info 
Detecting CXX compiler ABI info - done
Check for working CXX compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ - skipped 
Detecting CXX compile features 
Detecting CXX compile features - done
>>  Configuring done (0.8s) 
Generating done (0.0s) 
Build files have been written to: /Users/makbuk/lab06/_build 
_build % cmake --build . 
[ 10%] Building CXX object formatter_lib/CMakeFiles/formatter.dir/formatter.cpp.o 
[ 20%] Linking CXX static library libformatter.a 
[ 20%] Built target formatter 
[ 30%] Building CXX object formatter_ex_lib/CMakeFiles/formatter_ex.dir/formatter_ex.cpp.o 
[ 40%] Linking CXX static library libformatter_ex.a 
[ 40%] Built target formatter_ex 
[ 50%] Building CXX object solver_lib/CMakeFiles/solver_lib.dir/solver.cpp.o 
[ 60%] Linking CXX static library libsolver_lib.a 
[ 60%] Built target solver_lib 
[ 70%] Building CXX object hello_world_application/CMakeFiles/hello_world.dir/hello_world.cpp.o 
[ 80%] Linking CXX executable hello_world 
[ 80%] Built target hello_world 
[ 90%] Building CXX object solver_application/CMakeFiles/solver.dir/equation.cpp.o 
[100%] Linking CXX executable solver 
[100%] Built target solver 
makbuk@MacBook-Air-makbuk _build % cpack 
CPack: Create package using STGZ 
CPack: Install projects 
CPack: - Run preinstall target for: lab06 
CPack: - Install project: lab06 [] 
CPack: Create package 
CPack: - package: /Users/makbuk/lab06/_build/lab06-0.1.1-Darwin.sh generated. 
CPack: Create package using TGZ 
CPack: Install projects 
CPack: - Run preinstall target for: lab06 
CPack: - Install project: lab06 [] 
CPack: Create package 
CPack: - package: /Users/makbuk/lab06/_build/lab06-0.1.1-Darwin.tar.gz generated. 
% mkdir -p ../Arts 
% cd ../ 
lab06 % cp lab06-*.tar.gz Arts/   
zsh: no matches found: lab06-*.tar.gz 
makbuk@MacBook-Air-makbuk lab06 % ls -l _build/*.tar.gz 
-rw-r--r--  1 makbuk  staff  15930 19 май 22:27 _build/lab06-0.1.1-Darwin.tar.gz 
% cd Arts 
Arts % tar -xvzf lab06-0.1.1-Darwin.tar.gz --strip-components=1  
lab06 % cp _build/lab06-0.1.1-Darwin.tar.gz Arts/ 

lab6 %  git tag -a v1.0.2 -m "Test release" 
 % git push origin v1.0.2 
>>Enumerating objects: 1, done. 
Counting objects: 100% (1/1), done. 
Writing objects: 100% (1/1), 173 bytes | 173.00 KiB/s, done. 
Total 1 (delta 0), reused 0 (delta 0), pack-reused 0 
To https://github.com/Ekaterina416b/lab6 
 * [new tag]         v1.0.2 -> v1.0.2 
```
