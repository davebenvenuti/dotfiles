function kubectl_prompt_info() {
    prefix=$ZSH_THEME_KUBECTL_PROMPT_PREFIX
    suffix=$ZSH_THEME_KUBECTL_PROMPT_SUFFIX
    context=`kubectl config current-context`

    echo "${prefix}${context}${suffix}"
}
