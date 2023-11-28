if [[ "$cuda_compiler_version" == "None" ]]; then
  export FORCE_CUDA=0
else
  # Borrowed from PyTorch
  # ref: https://github.com/conda-forge/pytorch-cpu-feedstock/blob/7c7a57b7515eaeda67d3879b56b68466f38f0b0d/recipe/build_pytorch.sh#L129-L157
  export TORCH_CUDA_ARCH_LIST="5.0;6.0;6.1;7.0;7.5;8.0;8.6"
  if [[ "$cuda_compiler_version" == "11.2*" ]]; then
    export TORCH_CUDA_ARCH_LIST="3.5;$TORCH_CUDA_ARCH_LIST"
  elif [[ "$cuda_compiler_version" == "11.8" ]]; then
    export TORCH_CUDA_ARCH_LIST="3.5;$TORCH_CUDA_ARCH_LIST;8.9"
  elif [[ "$cuda_compiler_version" == "12.0" ]]; then
    export TORCH_CUDA_ARCH_LIST="$TORCH_CUDA_ARCH_LIST;8.9;9.0"
  else
      echo "unsupported cuda version. edit build.sh"
      exit 1
  fi
  export FORCE_CUDA=1
  export TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST}+PTX"
  echo "TORCH_CUDA_ARCH_LIST=${TORCH_CUDA_ARCH_LIST}"
fi

export TORCHVISION_INCLUDE="${PREFIX}/include/"
${PYTHON} -m pip install . -vv
