# kubektl
source /usr/local/Cellar/kube-ps1/0.6.0/share/kube-ps1.sh
KUBE_PS1_NS_ENABLE=false
KUBE_PS1_SEPARATOR=''
KUBE_PS1_PREFIX=' :: '
KUBE_PS1_SUFFIX=''
KUBE_PS1_CTX_COLOR=cyan

geometry_prompt_kube_setup() {}

geometry_prompt_kube_check() {
  return 0
}

geometry_prompt_kube_render() {
  if [[ $(kube_ps1) = *"production"* ]]; then
    KUBE_PS1_CTX_COLOR=red
  fi
  echo $(kube_ps1)
}


geometry_plugin_register kube

