include(ExternalProject)

macro(set_urls URLS)
  set(${URLS} ${ARGN})
endmacro()

set_urls(ARROW_SOURCE_URL
            "https://www.apache.org/dyn/closer.lua?action=download&filename=arrow/arrow-${SIMPLECMAKE_ARROW_BUILD_VERSION}/apache-arrow-${SIMPLECMAKE_ARROW_BUILD_VERSION}.tar.gz"
)

macro(BUILD_ARROW)
    set(ARROW_BUILD_DIR ${CMAKE_CURRENT_BINARY_DIR}/thirdparty/arrow)
    set(ARROW_BUILD_COMMAND 
        BUILD_COMMAND cmake ${CMAKE_SOURCE_DIR}/thirdparty/arrow/)

    ExternalProject_Add(arrow
        URL ${ARROW_SOURCE_URL}
        URL_HASH "SHA256=${SIMPLECMAKE_ARROW_BUILD_SHA256_CHECKSUM}"
    )
endmacro()
