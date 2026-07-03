#!/usr/bin/env bash
set -Eeuo pipefail

dbu_set_defaults() {
  : "${DBU_CONTAINER_NAME:=unity-dev}"
  : "${DBU_CONTAINER_IMAGE:=ubuntu:26.04}"

  : "${DBU_UNITY_ROOT:=$HOME/Unity}"
  : "${DBU_UNITY_PROJECTS:=$HOME/Unity/Projects}"
  : "${DBU_UNITY_EDITORS:=$HOME/Unity/Editors}"
  : "${DBU_UNITY_DOWNLOADS:=$HOME/Unity/Downloads}"
  : "${DBU_UNITY_CACHE:=$HOME/Unity/Cache}"
  : "${DBU_UNITY_LICENSES:=$HOME/Unity/Licenses}"

  : "${DBU_JETBRAINS_ROOT:=$HOME/JetBrains}"
  : "${DBU_ANDROID_ROOT:=$HOME/Android}"

  : "${DBU_INSTALL_GITKRAKEN:=true}"
}

dbu_load_config() {
  local config_file="${1:-}"

  dbu_set_defaults

  if [[ -n "$config_file" && -f "$config_file" ]]; then
    dbu_info "Loading config: $config_file"
    # shellcheck disable=SC1090
    source "$config_file"
  elif [[ -n "$config_file" ]]; then
    dbu_info "No config.env found; using defaults."
  fi

  dbu_set_defaults
}

dbu_create_unity_directories() {
  dbu_run mkdir -p \
    "$DBU_UNITY_PROJECTS" \
    "$DBU_UNITY_EDITORS" \
    "$DBU_UNITY_DOWNLOADS" \
    "$DBU_UNITY_CACHE" \
    "$DBU_UNITY_LICENSES" \
    "$DBU_JETBRAINS_ROOT" \
    "$DBU_ANDROID_ROOT"
}
