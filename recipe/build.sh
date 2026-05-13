cmake ${CMAKE_ARGS} \
      -G Ninja \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -S . \
      -B build

cmake --build build
cmake --build build --target install

# Separate debugging symbols on Linux
if [ -n "${OBJCOPY}" ]
then
  ${OBJCOPY} --only-keep-debug ${PREFIX}/lib/libhdb++.so.${LIBHDBPP_VERSION} ${PREFIX}/lib/libhdb++.so.${LIBHDBPP_VERSION}.dbg
  chmod 664 ${PREFIX}/lib/libhdb++.so.${LIBHDBPP_VERSION}.dbg
  ${OBJCOPY} --strip-debug ${PREFIX}/lib/libhdb++.so.${LIBHDBPP_VERSION}
  ${OBJCOPY} --add-gnu-debuglink=${PREFIX}/lib/libhdb++.so.${LIBHDBPP_VERSION}.dbg ${PREFIX}/lib/libhdb++.so.${LIBHDBPP_VERSION}
fi
