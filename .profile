export PATH="$PATH:/opt/rocm/bin"
export PATH="$PATH:$HOME/.local/bin"

# For ollama ROCm support
export HSA_OVERRIDE_GFX_VERSION="11.0.0"

export TERM=xterm

# For OpenXR stuff
export AMD_VULKAN_ICD=RADV
export XR_RUNTIME_JSON="$HOME/src/monado/build/openxr_monado-dev.json"

# Ollama stuff
export OLLAMA_API_BASE=http://127.0.0.1:11434
