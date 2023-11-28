if [[ "$cuda_compiler_version" == "None" ]]; then
  export FORCE_CUDA=0
else
  export TORCH_CUDA_ARCH_LIST="5.0;6.0;6.1;7.0;7.5;8.0;8.6"
  # Duplicate lists because of https://bitbucket.org/icl/magma/pull-requests/32
  export CUDA_ARCH_LIST="sm_50,sm_60,sm_70,sm_75,sm_80"
  export CUDAARCHS="50-real;60-real;70-real;75-real;80-real"
  if [[ ${cuda_compiler_version} == 9.0* ]]; then
      export TORCH_CUDA_ARCH_LIST="$TORCH_CUDA_ARCH_LIST;6.0;7.0"
  elif [[ ${cuda_compiler_version} == 9.2* ]]; then
      export TORCH_CUDA_ARCH_LIST="$TORCH_CUDA_ARCH_LIST;6.0;6.1;7.0"
  elif [[ ${cuda_compiler_version} == 10.* ]]; then
      export TORCH_CUDA_ARCH_LIST="$TORCH_CUDA_ARCH_LIST;6.0;6.1;7.0;7.5"
  elif [[ ${cuda_compiler_version} == 11.0* ]]; then
      export TORCH_CUDA_ARCH_LIST="$TORCH_CUDA_ARCH_LIST;6.0;6.1;7.0;7.5;8.0"
  elif [[ ${cuda_compiler_version} == 11.1* ]]; then
      export TORCH_CUDA_ARCH_LIST="$TORCH_CUDA_ARCH_LIST;6.0;6.1;7.0;7.5;8.0;8.6"
  elif [[ "$cuda_compiler_version" == "11.2*" ]]; then
    export CUDA_ARCH_LIST="${CUDA_ARCH_LIST},sm_35"
    export CUDAARCHS="${CUDAARCHS};35-virtual;80-virtual"
    export TORCH_CUDA_ARCH_LIST="$TORCH_CUDA_ARCH_LIST;6.0;6.1;7.0;7.5;8.0;8.6"
  elif [[ "$cuda_compiler_version" == "11.8" ]]; then
    export CUDA_ARCH_LIST="${CUDA_ARCH_LIST},sm_35,sm_89,sm_90"
    export CUDAARCHS="${CUDAARCHS};35-virtual;89-real;90"
  elif [[ "$cuda_compiler_version" == "12.0" ]]; then
    export CUDA_ARCH_LIST="${CUDA_ARCH_LIST},sm_89,sm_90"
    export CUDAARCHS="${CUDAARCHS};89-real;90"
  else
      echo "unsupported cuda version. edit build.sh"
      exit 1
  fi
  export FORCE_CUDA=1
fi

export TORCHVISION_INCLUDE="${PREFIX}/include/"
${PYTHON} -m pip install . -vv
