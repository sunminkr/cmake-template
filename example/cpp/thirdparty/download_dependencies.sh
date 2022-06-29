#!/usr/bin/env bash

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# This script downloads all the thirdparty dependencies as a series of tarballs
# that can be used for offline builds, etc.

set -eu

SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$#" -ne 1 ]; then
  orig_destdir=$(pwd)
else
  orig_destdir=$1
fi

# Try to canonicalize. Not all platforms support `readlink -f` or `realpath`.
# This only matters if there are symlinks you need to resolve before downloading
DESTDIR=$(readlink -f "${orig_destdir}" 2> /dev/null) || DESTDIR="${orig_destdir}"

download_dependency() {
  local url=$1
  local out=$2

  wget --quiet --continue --output-document="${out}" "${url}" || \
    (echo "Failed downloading ${url}" 1>&2; exit 1)
}

main() {
  mkdir -p "${DESTDIR}"

  # Load `DEPENDENCIES` variable.
  source ${SOURCE_DIR}/versions.txt

  echo "# Environment variables for offline Arrow build"
  for ((i = 0; i < ${#DEPENDENCIES[@]}; i++)); do
    local dep_packed=${DEPENDENCIES[$i]}

    # Unpack each entry of the form "$home_var $tar_out $dep_url"
    IFS=" " read -r dep_url_var dep_tar_name dep_url <<< "${dep_packed}"

    local out=${DESTDIR}/${dep_tar_name}
    download_dependency "${dep_url}" "${out}"

    echo "export ${dep_url_var}=${out}"
  done
}

main

#

ROOT_FOLDER=$(dirname $(realpath -s $0))
DOWNLOAD_FOLDER=${ROOT_FOLDER}/deps_download
INSTALL_FOLDER=${ROOT_FOLDER}/deps_build
THREAD_NUMBER=$(($(grep --count ^processor /proc/cpuinfo)/2))

download_dependency() {
    local url=$1
    local out=$2
    wget --quiet --continue --output-document="${out}" "${url}" || \
        (echo "Failed downloading ${url}" 1>&2; exit 1)
}

main() {
    mkdir -p ${DOWNLOAD_FOLDER}
    mkdir -p ${INSTALL_FOLDER}

    for ((i = 0; i < ${#DEPENDENCIES[@]}; i++)); do
        cd ${DOWNLOAD_FOLDER}
        local dep_packed=${DEPENDENCIES[$i]}
        IFS=" " read -r dep_url_var dep_tar_name dep_url <<< "${dep_packed}"
        local out=${DOWNLOAD_FOLDER}/${dep_tar_name}
        echo "download ${dep_tar_name} from ${dep_url}"
        download_dependency "${dep_url}" "${out}"
        tar --skip-old-files -zxvf ${out} 1>/dev/null 2>&1

    make_arrow
}

make_arrow() {
    cd $1/cpp/thirdparty
    declare -a deps_list
    while IFS=$'\n' read -r line
    do
        deps_list+=("${line}")
    done < <(./download_dependencies.sh)

    for ((i = 0; i < ${#deps_list[@]}; i++)); do
        ${deps_list[$i]}
    done

    cp -r ${ROOT_FOLDER}/arrow $1/cpp/src

    temp_build_folder=$1/cpp/build
    mkdir -p ${temp_build_folder}
    cmake $1/cpp -DCMAKE_BUILD_TYPE=Release -B${temp_build_folder} -DCMAKE_INSTALL_PREFIX=${INSTALL_FOLDER} \
    -DARROW_DEPENDENCY_SOURCE=BUNDLED -DARROW_CSV=ON -DARROW_FILESYSTEM=ON -DARROW_DATASET=ON \
    -DARROW_COMPUTE=ON -DARROW_PARQUET=ON -DARROW_FLIGHT=ON -DARROW_PLASMA=ON -DARROW_WITH_LZ4=ON \
    -DARROW_OPENSSL_USE_SHARED=OFF 1>/dev/null
    make -C ${temp_build_folder} -j${THREAD_NUMBER}
    make -C ${temp_build_folder} install 1>/dev/null
}

main